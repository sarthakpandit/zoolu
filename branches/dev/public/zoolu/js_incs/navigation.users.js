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
    
    this.rootLevelType = '';
  },
  
  /**
   * getModuleRootLevelList
   * @param integer rootLevelId
   */
   getModuleRootLevelList: function(rootLevelId, rootLevelType){
    
    this.rootLevelId = rootLevelId;
    this.rootLevelType = rootLevelType;
    
    $(this.genFormContainer).hide();
    $(this.genFormFunctions).hide();
    
    this.makeSelected('naviitem'+rootLevelId);
    if($(this.preSelectedPortal) && ('naviitem'+rootLevelId) != this.preSelectedPortal){ 
      this.makeDeselected(this.preSelectedPortal);
    }  
            
    this.preSelectedPortal = 'naviitem'+rootLevelId;
    this.rootLevelId = rootLevelId;
         
    new Ajax.Updater(this.genListContainer, this.constBasePath + '/' + this.rootLevelType + '/list', {
      parameters: { rootLevelId: this.rootLevelId },      
      evalScripts: true,     
      onComplete: function() {
        $(this.genListContainer).show();
        $(this.genListFunctions).show();
        
      }.bind(this)
    });
  },
  
  /**
   * getAddForm
   */
  getAddForm: function(){
    
    $(this.genListContainer).hide();
    $(this.genListFunctions).hide();
    
    new Ajax.Updater(this.genFormContainer, this.constBasePath + '/' + this.rootLevelType + '/addform', {
      parameters: { rootLevelId: this.rootLevelId },      
      evalScripts: true,     
      onComplete: function() {
        $(this.genFormContainer).show();
        $(this.genFormFunctions).show();
        
      }.bind(this)
    });
  }
});