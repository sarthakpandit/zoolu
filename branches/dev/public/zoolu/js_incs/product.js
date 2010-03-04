/**
 * product.js
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-11-12: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

Massiveart.Product = Class.create({

  initialize: function() {
    this.isStartProduct = false;
  },
  
  /**
   * changeType
   */
  changeType: function(typeId){
	  
    params = $H({productTypeId: typeId,
                 templateId: $F('templateId'),
                 formId: $F('formId'),
                 formVersion: $F('formVersion'),
                 formTypeId: $F('formTypeId'),
                 id: $F('id'),
                 linkId: ($('linkId')) ? $F('linkId') : -1,
                 languageId: $F('languageId'),
                 currLevel: $F('currLevel'),
                 rootLevelId: $F('rootLevelId'),
                 parentFolderId: $F('parentFolderId'),
                 parentTypeId: $F('parentTypeId'),
                 elementType: $F('elementType'),
                 isStartProduct: this.isStartProduct});
    
    $(myNavigation.genFormContainer).innerHTML = '';
    
    // loader
    myCore.addBusyClass(myNavigation.genFormContainer);
    myCore.addBusyClass('tdChangeType');    
    myForm.getFormSaveLoader();
    
    myCore.resetTinyMCE(true);
    
    new Ajax.Updater(myForm.updateContainer, '/zoolu/products/product/changeType', {
      parameters: params,
      evalScripts: true,
      onComplete: function() { 
        // load medias
        myForm.loadFileFieldsContent('media');
        // load documents
        myForm.loadFileFieldsContent('document');
        
        $('divMetaInfos').innerHTML = '';
        myCore.removeBusyClass(myNavigation.genFormContainer);
        myCore.removeBusyClass('tdChangeType');
        myForm.cancleFormSaveLoader();
      }.bind(this)
    });
  },

  /**
   * resetProductSearch
   */
  resetProductSearch: function(){
    if($('productSearchResult') && $('productSearchValue')){
      $('productSearchResult').innerHTML = '';
      $('productSearchValue').value = '';
    }
  },

  /**
   * searchProduct
   */
  searchProduct: function(){
    if($('productSearchResult') && $('productSearchValue') && !$F('productSearchValue').blank()){
      $('productSearchResult').innerHTML = '';
      myCore.addBusyClass('productSearchResult')
      new Ajax.Updater('productSearchResult', '/zoolu/products/product/overlaysearch', {
        parameters: {searchValue: $F('productSearchValue')},
        evalScripts: true,
        onComplete: function() {
          myCore.removeBusyClass('productSearchResult');
        }.bind(this)
      });
    }
  },

  /**
   * addProductLink
   */
  addProductLink: function(productId){
    if($('productSearchCurrLevel')){
      currLevel = $F('productSearchCurrLevel');

      new Ajax.Request('/zoolu/products/product/addproductlink', {
        parameters: {
            templateId: productTemplateDefaultId,
            rootLevelId: myNavigation.rootLevelId,
            parentFolderId: $('navlevel'+currLevel).readAttribute('parentid'),
            currLevel: currLevel,
            productTypeId: productTypeDefaultId,
            elementType: myNavigation.constProduct,
            isStartProduct: 0,
            linkId: productId
        },
        evalScripts: true,
        onComplete: function() {
          myNavigation.updateNavigationLevel(currLevel, $('navlevel'+currLevel).readAttribute('parentid'));
        }.bind(this)
      });
    }
  }

});