
function jGrowlTheme(type, header, message, image) {
	
	switch(type) {
		case "mono": 
			
			var theText 		= '<img src="' + image + '" class="img-thumb" /><span class="separator">&nbsp;</span>' + message;
	
			var themeAnimate = 	function() {
											setTimeout(function() { 
												JQ('img.img-thumb').animate({marginLeft: "-.5em"});
												JQ('.separator').animate({marginLeft: "-.3em"});
												JQ('div.jGrowl div.themed div.header').animate({marginLeft: "4.7em"}, 500);
												JQ('div.jGrowl div.themed div.message').animate({marginLeft: "6em"}, 1000);
											}, 10);
										}
					
			JQ.jGrowl(theText, {
						header: header,
						theme: 'themed', 
						open: themeAnimate
			});
			
		break;
		case "basic":
			
			var theText 		= '<img src="' + image + '" class="img-thumb-themed2" />' + message;
			var themedAnimate = 	function() {
											setTimeout(function() { 
												JQ('img.img-thumb-themed2').animate({right: "18em"}, 1000);
											}, 10);
										}
					
			JQ.jGrowl(theText, {
						header: header,
						theme: 'themed2', 
						open: themedAnimate
			});
			
		break;
	}
}