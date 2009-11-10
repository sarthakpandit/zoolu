/**
 * list.js
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-07: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

Massiveart.List = Class.create({
  
  initialize: function() {
    this.ItemsPerPage = 20;
    this.page = 1;
    
    this.sortColumn = '';
    this.sortOrder = '';
  },
  
  /**
   * getListPage
   */
  getListPage: function(page){
    if(myNavigation){      
      
      if(typeof(page) != 'undefined' && page > 0){ 
        this.page = page;
      }
      
      new Ajax.Updater(myNavigation.genListContainer, myNavigation.constBasePath + '/' + myNavigation.rootLevelType + '/list', {
        parameters: { 
    	  rootLevelId: myNavigation.rootLevelId, 
    	  page: this.page, 
    	  itemsPerPage: this.ItemsPerPage,
    	  order: this.sortColumn,
    	  sort: this.sortOrder
    	},      
        evalScripts: true,     
        onComplete: function() {
          $(myNavigation.genListContainer).show();
          $(myNavigation.genListFunctions).show();
          myCore.initSelectAll();
          myCore.initListHover();
        }.bind(this)
      });
    }
  },
  
  /**
   * sort
   */
  sort: function(sortColumn, sortOrder){
    if(typeof(sortColumn != 'undefined')) this.sortColumn = sortColumn;
    if(typeof(sortOrder != 'undefined')) this.sortOrder = sortOrder;
    myList.getListPage();
  },
  
  /**
   * deleteListItem
   */
  deleteListItem: function(){
    var arrEntries = [];
    var strEntries = '';
    var index = 0;
	$$('#listEntries input').each(function(e){ 
      if(e.type == 'checkbox'){
        if(e.checked){
          arrEntries[index] = e.value;
          strEntries += '[' + e.value + ']';
          index++;
        }
      }      
	});
	if(arrEntries.size() > 0){
      myCore.showDeleteAlertMessage(arrEntries.size());
      $('buttonOk').observe('click', function(event){
        new Ajax.Updater(myNavigation.genListContainer, myNavigation.constBasePath + '/' + myNavigation.rootLevelType + '/listdelete', {
    	  parameters: { 
    	    values: strEntries   
          },      
    	  evalScripts: true,     
    	  onComplete: function() {
            myCore.hideDeleteAlertMessage();  
    	  }.bind(this)
    	});        
      }.bind(this));
      $('buttonCancel').observe('click', function(event){
        myCore.hideDeleteAlertMessage();
      }.bind(this));
	}
  },
  
  /**
   * toggleEditMenu
   */
  toggleEditMenu: function(elementId){
    if($('buttonEditMenu')){
      Effect.toggle('buttonEditMenu', 'appear', { delay: 0, duration: 0.3 });
      if($(elementId) && $(elementId).hasClassName('white')){
        $(elementId).removeClassName('white');
      }else{
        $(elementId).addClassName('white');
      }
    }    
  }
  
});