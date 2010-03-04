/**
 * navigation.cms.js
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-03-09: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

Massiveart.Navigation.Cms = Class.create(Massiveart.Navigation, {

  initialize: function($super) {
    // initialize superclass
    $super();
  },
  
  /**
   * initModuleCMS
   */
  initModuleCMS: function(rootLevelId){
    if(typeof(rootLevelId) != 'undefined' && rootLevelId != ''){
      if($('portal'+rootLevelId)) $('portal'+rootLevelId).onclick();
      this.loadDashboard();
    }else{
      var blnFirst = true;
      $$('#divNaviLeftMain div.portal').each(function(elDiv){
	    if($(elDiv.id) && blnFirst){
	      $(elDiv.id).onclick();
	      blnFirst = false;
	    }	      
	  }.bind(this));
      
      if(blnFirst == true){
        this.loadDashboard();
      }
    }
  },
  
  /**
   * loadDashboard
   */
  loadDashboard: function(){
    $(this.genFormContainer).show();
    myCore.removeBusyClass(this.genFormContainer);
    
    myCore.resetTinyMCE(true);
    
    new Ajax.Updater(this.genFormContainer, '/zoolu/cms/page/dashboard', {
      parameters: { 
        rootLevelId: this.rootLevelId
      },      
      evalScripts: true,     
      onComplete: function() {
        myCore.removeBusyClass(this.genFormContainer);
        myCore.initListHover(false);
      }.bind(this)
    });
  }

});