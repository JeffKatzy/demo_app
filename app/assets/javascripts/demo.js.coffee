window.app =
  pusher: null
  selected_channel: null
  ready: ->
    app.pusher = new Pusher('95782993eddc91180006')
    app.selected_channel = 'classroom_' + $('#container').data('classroom')
    app.subscribe_channel(app.selected_channel)
    app.bind_events()
    $('body').on('click', '#analytics', app.analytics_view)
    $('body').on('click', '.active_student', app.show_graph)
    $('body').on('click', '#live', app.live_view)
    $('#assignments').on('mouseenter', 'li.movable', app.hover_enter)
    $('#assignments').on('mouseleave', 'li.movable', app.hover_leave)
    $('#assignments').on('click', 'li.movable', app.assign)
  subscribe_channel: (channel) ->
    app.pusher.subscribe(channel)
  bind_events: ->
    console.log('events binding')
    channel = app.pusher.channels.channels[app.selected_channel]
    channel.bind('update_student_answer', app.update_student_answer)
    channel.bind('update_student_lecture', app.update_student_lecture)
  update_student_answer: (data) ->
    user_class = ".user_#{data.user} .data"
    correct = data.correct
    total_questions = data.total_lecture_questions
    new_number_complete = $(user_class).data('number_complete') + 1
    old_number_correct = $(user_class).data('number_correct')
    if data.correct
      new_number_correct = old_number_correct + 1
    else
      new_number_correct = old_number_correct
    console.log(new_number_correct)
    console.log(total_questions)
    new_percentage = (new_number_correct / new_number_complete) * 100
    $(user_class).data("number_complete", new_number_complete)
    $(user_class).data("number_correct", new_number_correct)
    $(".user_#{data.user} .number_complete").text(new_number_complete)
    $(".user_#{data.user} .number_correct").text(new_number_correct)
    $(".user_#{data.user} .percentage_correct").text(Math.round(new_percentage*10)/10)
  update_student_lecture: (data) ->
    console.log(data)
    user_class = ".user_#{data.user}"
    lecture = data.user_lecture
    $(".user_#{data.user} .lecture_name").text(lecture)
  analytics_view: ->
    $('#add_student').hide()
    $('.element .percentage_correct').hide()
    $('.element .number_complete').hide()
    $('.label_percent').hide()
    $('.label_complete').hide()
    $(".element").css('margin', '0px')
    $(".element").css('border', '2px solid black')
    $(".element").animate({"height": "25px"}, "fast", -> $("#container").isotope( 'reloadItems' ).isotope({ layoutMode : 'straightDown' });)
    $(".element").addClass('active_student')
    $('.element').first().children('.name').click()
    $('dl').slideUp()
  live_view: ->
    $('#chart').slideUp()
    $('.element').children('.name').children('a').css('background', 'rgb(64, 64, 64)').css('color', 'white')
    $('.element .percentage_correct').show()
    $('.element .number_complete').show()
    $('.label_percent').show()
    $('.label_complete').show()
    $(".element").css('margin', '20px')
    $(".element").css('border', 'none')
    $(".element").animate({"height": "70px"}, "fast", -> $("#container").isotope( 'reloadItems' ).isotope({ layoutMode : 'masonry' });)
    $(".element").removeClass('active_student')
    $('dl').slideDown()
    $('#add_student').show()
  show_graph: ->
    $('#chart').show()
    user_id = $(this).children('.data').data('user_id')
    $('.element').children('.name').children('a').css('background', 'rgb(64, 64, 64)').css('color', 'white')
    $(this).children('.name').children('a').css('background', 'rgb(242, 232, 92)').css('color', 'black')
    console.log(user_id)
    settings =
      dataType: 'json'
      type: 'get'
      url: "/classrooms/chart/#{user_id}"
    $.ajax(settings).done(app.show_chart)
  show_chart: (data) ->
    console.log(data)
    $('#chart').empty()
    new Morris.Bar
      element: 'chart',
      data: data ,
      xkey: 'y',
      ykeys: ['a'],
      labels: ['Percent Correct']
  hover_enter: ->
    $(this).addClass('hover-enter')
  hover_leave: ->
    $(this).removeClass('hover-enter')
  assign: ->
    token = $('#assignment_classroom').data('auth-token')
    classroom_id = $('#assignment_classroom').data('classroom-id')
    lecture_id = $(this).data('lecture-id')
    settings =
      dataType: 'script'
      type: "post"
      url: "/classrooms/#{classroom_id}/assign"
      data: {authenticity_token: token, lecture_id: lecture_id}
    $.ajax(settings)



$(document).ready(app.ready)