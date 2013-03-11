$(function(){
  $('.vertical.tabs').on('click', 'dd', find_content);
});

function find_content()
{
  var selected = $(this).text();
  render_content(selected);
}

function render_content(selected)
{
  if(selected == "Percent Correct")
    {
    $('.topic').hide();
    $('.time_per_lecture').hide();
    $('.percent_correct').show();
  }
  else if(selected == "Topic")
    { $('.topic').show();
      console.log('topic');
    $('.percent_correct').hide();
    $('.time_per_lecture').hide();
     }
  else if(selected == "Time per lecture")
    $('.time_per_lecture').show();
    $('.percent_correct').hide();
    $('.topic').hide();
}