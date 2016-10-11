var eventsManager = {
	on: function(event, callback, element, useCapture) {
		element.addEventListener(event, callback, useCapture === undefined ? false : useCapture);
	},
	no: function(event, callback, element) {
		element.removeEventListener(event, callback);
	},
	apply: function(element) {
		element.on = function(event, callback) {window.eventsManager.on(event, callback, this);};
		element.no = function(event, callback) {window.eventsManager.no(event, callback, this);};
	},
	init: function() {
		this.apply(window);
		this.apply(Node.prototype);
	}
};

eventsManager.init();
var Request = function(url, data, method, json) {
	var self = this;

	this.url = url;
	method = typeof method == 'string' ? method.toUpperCase() : 'GET';
	this.data = typeof data == 'object' ? data : {};
	this.method = method != 'GET' && method != 'POST' ? 'GET' : method;
	this.xhr = new XMLHttpRequest();
	this.json = json ? true : false;

	this.onNotInitialized;
	this.onConnectionEstablished;
	this.onRecieved;
	this.onProcessing;
	this.onFinished;

	this.onSuccess;
	this.onError;

	this.notInitialized = function(c){this.onNotInitialized = c;return this;};
	this.connectionEstablished = function(c){this.onConnectionEstablished = c;return this;};
	this.recieved = function(c){this.onRecieved = c;return this;};
	this.processing = function(c){this.onProcessing = c;return this;};
	this.finished = function(c){this.onFinished = c;return this;};

	this.success = function(c){this.onSuccess = c;return this;};
	this.error = function(c){this.onError = c;return this;};

	Object.defineProperties(this, {
		state: {get: function(){return this.xhr.readyState;}},
		status: {get: function(){return this.xhr.status;}},
		response: {get: function(){return this.xhr.responseText;}},
		params: {get: function(){return Request.encodeData(this.data);}}
	});

	this.xhr.onreadystatechange = function() {
		switch(self.state) {
			case Request.notInitialized:
				if(typeof self.onNotInitialized == 'function') self.onNotInitialized();
				break;
			case Request.connectionEstablished:
				if(typeof self.onConnectionEstablished == 'function') self.onConnectionEstablished();
				break;
			case Request.recieved:
				if(typeof self.onRecieved == 'function') self.onRecieved();
				break;
			case Request.processing:
				if(typeof self.onProcessing == 'function') self.onProcessing();
				break;
			case Request.finished:
				var response = self.response;
				if(self.json && typeof response == 'string') {
					try {var response = JSON.parse(response);}
					catch(e) {var response = self.response;}
				}
				if(typeof self.onFinished == 'function') self.onFinished(self.status, response);
				if(self.status == 200) {
					if(typeof self.onSuccess == 'function') self.onSuccess(response);
				}
				else {
					if(typeof self.onError == 'function') self.onError(self.status);
				}
				break;
		}
	}

	this.send = function(data) {
		if(typeof data == 'object' && data !== null) this.data = data;

		this.xhr.open(this.method, this.url, true);

		if(this.method.toUpperCase() == 'POST') {
			this.xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
		}
		else {
			this.xhr.setRequestHeader('Content-type', '');
		}

		this.xhr.send(this.params);
	};
};

Request.notInitialized = 0;
Request.connectionEstablished = 1;
Request.recieved = 2;
Request.processing = 3;
Request.finished = 4;

Request.to = function(url, data, method) {
	return new Request(url, data, method);
};

Request.json = function(url, data, method) {
	var request = new Request(url, data, method);
	request.json = true;
	return request;
};

Request.encodeData = function(data, tree) {
	if(typeof tree != 'string') tree = '';
	var params = '';
	for(var p in data) {
		if(typeof data[p] == 'string' || typeof data[p] == 'number' || typeof data[p] == 'boolean') {
			params += tree+(tree == ''? p : '['+p+']')+'='+encodeURIComponent(data[p])+'&';
		}
		else if(typeof data[p] == 'object') {
			params += this.encodeData(data[p], tree+(tree == '' ? p : '['+p+']'));
		}
	}
	return params.replace(/&$/, '');
};
var Search = function(element, entity, path, callback, property) {
	var self = this;

	if(typeof callback != 'function') callback = function() {};
	if(property === undefined) property = 'content';

	var selected = -1;

	Object.defineProperties(this, {
		element: {
			value: element
		},
		callback: {
			get: function() {
				return callback;
			},
			set: function(v) {
				callback = typeof v == 'callback' ? v : function() {};
			}
		},
		property: {
			value: property
		},
		input: {
			value: element.getElementsByTagName('input')[0]
		},
		value: {
			get: function() {
				return this.input.value;
			},
			set: function(v) {
				this.input.value = v;
			}
		},
		box: {
			value: document.createElement('ul')
		},
		options: {
			get: function() {
				return this.box.getElementsByTagName('li');
			}
		},
		length: {
			get: function() {
				return this.options.length;
			}
		},
		request: {
			value: new Request(path)
		},
		params: {
			value: function(search) {
				var params = {};
				params[entity] = {
					search: search
				};

				return params;
			}
		},
		for: {
			value: function(search, callback) {
				this.request.success(function(response) {
					callback(response);
				}).send(this.params(search));
			}
		},
		clear: {
			value: function() {
				selected = -1;
				this.box.innerHTML = '';
			}
		},
		fill: {
			value: function(result) {
				this.clear();

				if(result.length == 0) this.hide();
				else if(result.length == 1 && result[0][this.property] == this.value) this.hide();
				else {
					if(this.hidden) this.show();

					for(var i = 0; i < result.length; i++) {
						var li = document.createElement('li');
						li.appendChild(document.createTextNode(result[i][this.property]));
						li.result = result[i];

						this.box.appendChild(li);
					}
				}
			}
		},
		hidden: {
			get: function() {
				return this.box.className != 'visible';
			}
		},
		hide: {
			value: function() {
				this.box.className = '';
			}
		},
		show: {
			value: function() {
				this.box.className = 'visible';
			}
		},
		blur: {
			value: function() {
				this.input.blur();
			}
		},
		onkeydown: {
			value: function(event) {
				var self = this;
				options = self.options;

				switch(event.keyCode) {
					case 38:
						if(selected - 1 >= 0) {
							options[selected].className = '';
							selected--;
							event.preventDefault();
						}
						break;
					case 40:
						if(selected + 1 < options.length) {
							if(selected != -1) options[selected].className = '';
							selected++;
							event.preventDefault();
						}
						break;
					case 13:
						if(selected != -1) {
							event.preventDefault();
							event.stopPropagation();

							value = callback(options[selected].result);
							if(value === undefined) value = options[selected].textContent;

							this.value = value;

							self.hide();
							self.clear();
						}
						break;
					case 9:
						self.hide();
						self.clear();
						break;
					default:
						setTimeout(function() {
							if(self.value.replace(/\s/, '') == '') {
								self.hide();
								self.clear();
							}
							else {
								self.for(self.value, function(response) {
									self.fill(response);
								});
							}
						}, 1);
				}

				if(selected != -1) {
					options[selected].className = 'selected';
				}
			}
		}
	});

	this.request.method = 'post';
	this.request.json = true;

	this.element.appendChild(this.box);

	this.input.setAttribute('autocomplete', 'off');

	this.input.on('keydown', function(event) {
		self.onkeydown(event);
	});
};
var articlesForm = {
	element: document.getElementById('search-question'),
	search: null,
	set id(v) {
		document.getElementById('article_question_id').value = v;
	},
	callback: function(result) {
		this.id = result.id;
	},
	init: function() {
		var self = this;

		this.search = new Search(this.element, 'question', routes.search_question_path, function(result) {
			self.callback(result);
		});
	}
};

articlesForm.init();





