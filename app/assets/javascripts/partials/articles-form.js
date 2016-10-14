var articlesForm = {
	element: document.getElementById('search-question'),
	search: null,
	form: {
		element: document.getElementById('article_content'),
		init: function() {
			tinymce.init({
				selector: '#'+this.element.id
			});
		}
	},
	set id(v) {
		document.getElementById('article_question_id').value = v;
	},
	callback: function(result) {
		this.id = result.id;
	},
	init: function() {
		var self = this;

		this.form.init();

		this.search = new Search(this.element, 'question', routes.search_questions, function(result) {
			self.callback(result);
		});
	}
};

articlesForm.init();
