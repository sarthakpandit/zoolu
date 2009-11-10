/**
 * navigation.products.js
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-03-09: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

Massiveart.Navigation.Products = Class.create(Massiveart.Navigation, {

  initialize: function($super) {
    // initialize superclass
    $super();

    this.constBasePath = '/zoolu/products';

    this.rootLevelType = '';
  },
  
  /**
   * addProduct
   */
  addProduct: function(currLevel){
    $('buttondelete').hide();
    this.showFormContainer();    
        
    $(this.genFormContainer).innerHTML = '';
    $('divWidgetMetaInfos').innerHTML = '';
    
    $(this.genFormContainer).show();
    $(this.genFormSaveContainer).show();
        
    myCore.addBusyClass(this.genFormContainer);
    myCore.addBusyClass('divWidgetMetaInfos');
    
    new Ajax.Updater('genFormContainer', '/zoolu/products/product/getaddform', {
      parameters: {
        templateId: productTemplateDefaultId,
        rootLevelId: this.rootLevelId,
        parentFolderId: $('navlevel'+currLevel).readAttribute('parentid'),
        currLevel: currLevel,
        productTypeId: productTypeDefaultId,
        elementType: this.constProduct,
        isStartProduct: 0       
      },      
      evalScripts: true,     
      onComplete: function() {
        myForm.writeMetaInfos();
        
        $('levelmenu'+currLevel).hide();
        $('addmenu'+currLevel).fade({duration: 0.5});
        myCore.removeBusyClass('divWidgetMetaInfos');
        myCore.removeBusyClass(this.genFormContainer);              
      }.bind(this)
    });    
  }

});