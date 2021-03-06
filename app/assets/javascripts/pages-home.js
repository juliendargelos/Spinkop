//=require components/eventsManager
//=require components/scroll

var main = {
	header: {
		element: document.getElementsByTagName('header')[0],
		set visible(v) {
			if(v && this.element.className != 'visible') this.element.className = 'visible';
			else if(!v && this.element.className != '') this.element.className = '';
		},
		hero: {
			element: document.getElementsByTagName('header')[0].getElementsByClassName('hero')[0],
			content: document.getElementsByTagName('header')[0].getElementsByClassName('hero')[0].getElementsByClassName('wrapper')[0],
			ratio: 286/250,
			parallaxRatio: 0.3,
			get width() {
				return this.element.offsetWidth;
			},
			get height() {
				return this.element.offsetHeight;
			},
			get backgroundHeight() {
				return this.width/this.height < this.ratio ? this.height : this.width*this.ratio;
			},
			set backgroundPosition(v) {
				var backgroundPosition = (this.height-this.backgroundHeight)/2+v;

				this.element.style.backgroundPosition = 'center '+backgroundPosition+'px';
			},
			set contentPosition(v) {
				this.content.style.top = this.height/2+v+'px';
			},
			set opacity(v) {
				this.element.style.opacity = v < 0 ? 0 : (v > 1 ? 1 : v);
			},
			onscroll: function() {
				this.backgroundPosition = scroll.top*this.parallaxRatio;
				this.contentPosition = scroll.top*this.parallaxRatio;
				this.opacity = 1-scroll.top/(this.height - main.header.bar.height);
			},
			init: function() {
				var self = this;

				on('scroll', function() {
					self.onscroll();
				});

				on('resize', function() {
					self.onscroll();
				});
			}
		},
		bar: {
			element: document.getElementsByTagName('header')[0].getElementsByClassName('bar')[0],
			get height() {
				return this.element.offsetHeight;
			},
			onscroll: function() {
				main.header.visible = scroll.top > main.header.hero.height - this.height;
			}
		},
		onscroll: function() {
			this.hero.onscroll();
			this.bar.onscroll();
		},
		init: function() {
			var self = this;

			on('scroll', function() {
				self.onscroll();
			});

			on('resize', function() {
				self.onscroll();
			});
		}
	},
	init: function() {
		this.header.init();
	}
};

main.init();
