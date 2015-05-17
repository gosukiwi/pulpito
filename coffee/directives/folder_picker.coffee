app.directive 'folderPicker', ->
  restrict: 'E'
  templateUrl: 'templates/folder_picker.html'
  scope:
    onSelect: '&'
  link: (scope, element, attrs) ->
    el = element.get(0)
    window.ondragover = (e) ->
      e.preventDefault()
      false
    window.ondrop = (e) ->
      e.preventDefault()
      false
    el.ondragover = (e) ->
      e.preventDefault()
      false
    el.ondragleave = (e) ->
      e.preventDefault()
      false
    el.ondrop = (e) ->
      e.preventDefault()
      path = e.dataTransfer.files[0].path
      scope.onSelect()(path)
      false
