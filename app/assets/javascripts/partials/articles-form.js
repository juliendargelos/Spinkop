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

		this.search = new Search(this.element, 'question', routes.search_questions, function(result) {
			self.callback(result);
		});
	}
};

articlesForm.init();
