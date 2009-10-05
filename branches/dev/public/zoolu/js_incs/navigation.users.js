/**
 * navigation.users.js
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-05: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

Massiveart.Navigation.Users = Class.create(Massiveart.Navigation, {

  initialize: function($super) {
    // initialize superclass
    $super();
    
    this.constBasePath = '/zoolu/users';
  },
  
  /**
   * getModuleRootLevelList
   * @param integer rootLevelId
   */
   getModuleRootLevelList: function(rootLevelId, rootLevelType){
    
    $(this.genFormContainer).hide();
    $(this.genFormFunctions).hide();
    
    this.makeSelected('naviitem'+rootLevelId);
    if($(this.preSelectedPortal) && ('naviitem'+rootLevelId) != this.preSelectedPortal){ 
      this.makeDeselected(this.preSelectedPortal);
    }  
            
    this.preSelectedPortal = 'naviitem'+rootLevelId;
    this.rootLevelId = rootLevelId;
         
    new Ajax.Updater(this.genListContainer, this.constBasePath + '/' + rootLevelType + '/list', {
      parameters: { rootLevelId: this.rootLevelId },      
      evalScripts: true,     
      onComplete: function() {
        $(this.genListContainer).show();
        $(this.genListFunctions).show();
        
      }.bind(this)
    });
  }
});