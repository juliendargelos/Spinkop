//=require components/eventsManager
//=require components/scroll
//=require components/Request
//=require components/Search

var main = {
	searchBar: {
		element: document.getElementById('search-question'),
		search: null,
		callback: function(question) {
			window.location.href = routes.question(question.slug);
		},
		init: function() {
			var self = this;

			this.search = new Search(this.element, 'question', routes.search_questions, function(question) {
				self.callback(question);
			}, 'content', 4);
		}
	},
	questions: {
		element: document.getElementsByClassName('questions')[0],
		links: null,
		onmouseover: function(element) {
			return function() {
				element.style.background = theme.color;
				element.style.borderColor = theme.color;
			};
		},
		onmouseout: function(element) {
			return function() {
				element.style.background = '';
				element.style.borderColor = '';
			}
		},
		init: function() {
			this.links = this.element.getElementsByTagName('a');

			for(var i = 0; i < this.links.length; i++) {
				var link = this.links[i];
				link.on('mouseover', this.onmouseover(link));
				link.on('mouseout', this.onmouseout(link));
			}
		}
	},
	init: function() {
		this.searchBar.init();
		this.questions.init();
	}
};

main.init();
