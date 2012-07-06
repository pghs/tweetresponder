# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('.btn.btn-success').click -> 
		respond(1, $(this).attr('id'))
	$('.btn.btn-danger').click -> 
		respond(0, $(this).attr('id'))
	$('.btn.btn-warning').click -> 
		respond(-1, $(this).attr('id'))

	respond = (correct, id) ->
		mem = {}
		mem['tweet_id'] = parseInt id
		mem['correct'] = correct
		console.log mem
		$.ajax '/tweet/respond_to_tweet',
			type: 'POST'
			dataType: 'html'
			data: mem
			error: (jqXHR, textStatus, errorThrown) ->
				console.log "AJAX Error: #{errorThrown}"
			success: (data, textStatus, jqXHR) ->
				console.log "Success"
				$("##{id}").hide()