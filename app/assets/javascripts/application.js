//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .

$(document).ready(function() {
    $('.character').click(function() {
        var id = $(this).attr('id');

        $.ajax({
            url: "/people/" + id,
            contentType: 'application/json'
        })
    })

    $('.fade').click(function() {
        $('.fade-wrapper').hide();
    })
});

