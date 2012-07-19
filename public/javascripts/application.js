// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//sign in
        $(document).ready(function() {
           // Prepare layout options.
        	$('.dropdown-toggle').dropdown();
        //sign in button
            $(".dropdown-signin").click(function(e) {          
				e.preventDefault();
                $("#signin_menu").toggle();
				
            });
			
			$("#signin_menu").mouseup(function() {
				return false
			});
			$(document).mouseup(function(e) {
				if($(e.target).parent("a.dropdown-signin").length==0) {
					
					$("#signin_menu").hide();
				}
			});

        //button on top of image
       $('ul#tiles a').mouseover(function(){
        $(this).prev().css('display','inline-block');
      });	
      $('ul#tiles a').mouseout(function(){
 
         $(this).prev().css('display','none');
      
     });
      
     $('.button_group').mouseout(function(){
      $(this).css('display','none');
   });
     $('.button_group').mouseover(function(){
      $(this).css('display','inline-block');
   });

   //comment list style

   $(".comment").filter(':even').css("background-color","#F2F2F2");
   $(".comment").mouseover(function(){
   $(this).addClass("comment_background");
});
   $(".comment").mouseout(function(){
   $(this).removeClass("comment_background");
});

  //comment button click
  $('.comment_button').click(function(){
   $(this).parent().siblings(".comment_div").css("display","block");
});
  $('.title_popover').popover('hide');




});



