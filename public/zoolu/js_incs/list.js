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
  },
  
  page: function(page){
    if(myNavigation){
      new Ajax.Updater(myNavigation.genListContainer, myNavigation.constBasePath + '/' + myNavigation.rootLevelType + '/list', {
        parameters: { rootLevelId: this.rootLevelId, page: page, itemsPerPage: this.ItemsPerPage },      
        evalScripts: true,     
        onComplete: function() {
          $(this.genListContainer).show();
          $(this.genListFunctions).show();
        }.bind(this)
      });
    }
  },
  
  del: function(){
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