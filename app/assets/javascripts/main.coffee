$(document).on 'ready page:load', ->

#  ===============================
#  bootstrap-multiselect
#  ===============================

  $('.bootstrap-multiselect').multiselect
    includeSelectAllOption: true
    enableFiltering: true
    maxHeight: 300
    templates:
      button: '<button type="button" class="multiselect dropdown-toggle" data-toggle="dropdown"><span class="multiselect-selected-text">Select permissions</span>&nbsp;<b class="caret"></b></button>'
      ul: '<ul class="multiselect-container dropdown-menu"></ul>'
      filter: '<li class="multiselect-item filter"><div class="input-group"><input class="form-control multiselect-search" type="text"></div></li>'
      filterClearBtn: ''
      li: '<li><a href="javascript:void(0);"><label></label></a></li>'
      divider: '<li class="multiselect-item divider"></li>'
      liGroup: '<li class="multiselect-item multiselect-group"><label></label></li>'
  return