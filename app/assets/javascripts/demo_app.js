$(function(){
  // setLayout();
   sortData();
   $('.percent_correct').click(sortPercentCorrect);
    $('.number_completed').click(sortNumberComplete);
   // $('.tab').click(setLayout);
});


function setLayout(){
  $('#container1').isotope({ layoutMode : 'fitRows' });
  // $('#container1').isotope({ layoutMode : 'fitRows' });
  // $('#container2').isotope({ layoutMode : 'fitRows' });
  // $('#container3').isotope({ layoutMode : 'fitRows' });
}

function sortData(){
   $('.container').isotope({
    getSortData : {
    name : function ( $elem ) {
      console.log($elem.find('.name').text());
      return parseInt( $elem.find('.name').text(), 10 );
      },

      symbol : function ( $elem ) {
      return $elem.find('.number_complete').text();
      }
    }
  });
}



  function sortPercentCorrect(){
    console.log('hello');
  $('.container').isotope({ sortBy : 'name', sortAscending : false });
  }

  function sortNumberComplete(){
    console.log('helloone');
  $('.container').isotope({ sortBy : 'number_complete' });
  }



// $(function(){
//   $('.vertical.tabs').on('click', 'dd', find_content);

// });

// function find_content()
// {
//   var selected = $(this).text();
//   render_content(selected);
// }

// function render_content(selected)
// {
//   if(selected == "Percent Correct")
//     {
//     $('.topic').hide();
//     $('.time_per_lecture').hide();
//     $('.percent_correct').show();
//   }
//   else if(selected == "Topic")
//     { $('.topic').show();
//       console.log('topic');
//     $('.percent_correct').hide();
//     $('.time_per_lecture').hide();
//      }
//   else if(selected == "Time per lecture")
//     $('.time_per_lecture').show();
//     $('.percent_correct').hide();
//     $('.topic').hide();
// }

// $('#container').isotope({
//   getSortData : {
//     number : function ( $elem ) {
//     return parseInt( $elem.find('.name').text(), 10 );
//   }
// });

// $('#container').isotope({ sortBy : 'name' });