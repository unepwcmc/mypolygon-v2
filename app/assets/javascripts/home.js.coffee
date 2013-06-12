$(document).ready ->
  inputsWithPlaceholder = $('[placeholder]')

  inputsWithPlaceholder.focus ->
    input = $(this)
    if input.val() == input.attr('placeholder')
      input.val('')
      input.removeClass('placeholder')

  inputsWithPlaceholder.blur ->
    input = $(this)
    if input.val() == '' || input.val() == input.attr('placeholder')
      input.addClass('placeholder')
      input.val(input.attr('placeholder'))

  inputsWithPlaceholder.parents('form').submit( ->
    $(this).find('[placeholder]').each( ->
      input = $(this)

      if input.val() == input.attr('placeholder')
        input.val('')
    )
  )
