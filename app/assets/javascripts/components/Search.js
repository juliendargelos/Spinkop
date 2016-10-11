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
