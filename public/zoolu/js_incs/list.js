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
  },
  
  getListPage: function(page){
    if(myNavigation){      
      
      if(typeof(page) != 'undefined' && page > 0){ 
        this.page = page;
      }
      
      new Ajax.Updater(myNavigation.genListContainer, myNavigation.constBasePath + '/' + myNavigation.rootLevelType + '/list', {
        parameters: { rootLevelId: myNavigation.rootLevelId, page: this.page, itemsPerPage: this.ItemsPerPage },      
        evalScripts: true,     
        onComplete: function() {
          $(myNavigation.genListContainer).show();
          $(myNavigation.genListFunctions).show();
        }.bind(this)
      });
    }
  },
  
  deleteListItem: function(){
    alert('In Arbeit!');    
  },
  
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