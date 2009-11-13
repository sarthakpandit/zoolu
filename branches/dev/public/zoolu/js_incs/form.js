/**
 * form.js
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-04: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

Massiveart.Form = Class.create({
  
  initialize: function() {
    this.formId = 'genForm';  
    this.updateContainer = 'genFormContainer';
    this.updateOverlayContainer = 'overlayGenContent';
    
    this.portalId = 0;
    this.preSelectedPortal = '';
    this.selectedPortal = '';
    
    this.preSelectedItem = '';
    this.selectedItem = '';
    this.currLevel = 0;
    
    this.levelArray = [];
    
    this.regionTexteditorObj = new Object;
    this.texteditorArray = [];
    
    this.regionTitleObj = new Object;
    this.titleArray = [];
    
    this.blnShowFormAlert = true;
    this.selectNavigationItemNow = false;
    
    this.activeTabId = null;
  },
  
  /**
   * save
   */
  save: function(){
      if($(this.formId)){
      
      /**
       * write/save texteditor content to generic form
       */
      if($$('.texteditor')){
        tinyMCE.triggerSave();
      }
           
      /**
       * serialize generic form
       */
      var serializedForm = $(this.formId).serialize();
      
      // loader
      this.getFormSaveLoader();
      
      new Ajax.Updater(this.updateContainer, $(this.formId).readAttribute('action'), {
        parameters: serializedForm,
        evalScripts: true,
        onComplete: function() {         
          if(this.blnShowFormAlert){
            if($('rootLevelId') && $F('rootLevelId') != '' && $F('rootLevelId') > 0){
              myNavigation.updateNavigationLevel();
            }

            //saved
            this.getFormSaveSucces();

            if($('isStartPage') && $F('isStartPage') == 0){
              $('buttondelete').show();
            }
          }else{
            this.getFormSaveError();
          }
          // load medias
          this.loadFileFieldsContent('media');
          // load documents
          this.loadFileFieldsContent('document');
          // load contacts
          this.loadContactFieldsContent();

          if(this.selectNavigationItemNow == true){
            myNavigation.selectItem();
          }
        }.bind(this)
      });
    }
  },
  
  /**
   * deleteElement
   */
  deleteElement: function(){
    
    if($(this.formId)){
      
      var intPosLastSlash = $(this.formId).readAttribute('action').lastIndexOf('/');
      var strAjaxActionBase = $(this.formId).readAttribute('action').substring(0, intPosLastSlash + 1);
      var elType = $('elementType').getValue();
      var elementId = $('id').getValue();
      var linkId = ($('linkId')) ? $F('linkId') : -1;
      var parentFolderId = ($('parentFolderId')) ? $F('parentFolderId') : 0;
            
      // loader
      this.getFormSaveLoader();
      
      new Ajax.Updater(this.updateContainer, strAjaxActionBase + 'delete', {
        parameters: { id: elementId, linkId: linkId },
        evalScripts: true,
        onComplete: function() {
          //deleted
          this.getFormDeleteSucces();
          
          new Effect.Highlight(elType+elementId, {startcolor: '#ffd300', endcolor: '#ffffff'});
          $(elType+elementId).fade({duration: 0.5});
          //setTimeout('$("'+elType+elementId+'").remove()', 500);
          
          $(myNavigation.genFormContainer).hide();
          $(myNavigation.genFormSaveContainer).hide();   
          
          if(parentFolderId > 0){
            myNavigation.itemId = parentFolderId;
            myNavigation.selectItem();
          }else{
            myNavigation.hideCurrentFolder();
          }      
        }.bind(this)
      });
    }
  },
  
  /**
   * loadFileFieldsContent
   * @param string strType
   */
  loadFileFieldsContent: function(strType){
	
    if(strType != ''){
    	
      var strViewType = 0;
      if(strType == 'document'){
        strViewType = 2; // viewtypes->list constant of config.xml
      }else{
        strViewType = 1; // viewtypes->thumb constant of config.xml
      }
      
      $$('#genFormContainer .'+strType).each(function(elDiv){    
        if($(elDiv.id)){          
          var fileFieldId = elDiv.id.substring(elDiv.id.indexOf('_')+1);
          if($(fileFieldId).value != ''){
            myCore.addBusyClass(elDiv.id);            
            new Ajax.Updater(elDiv.id, '/zoolu/cms/page/getfiles', {
	          parameters: { 
	            fileIds: $(fileFieldId).value,
	            fileFieldId: fileFieldId,
	            viewtype: strViewType  
	          },
	          evalScripts: true,
	          onComplete: function(){
	            // add the scriptaculous sortable functionality to the parent container
	            switch(strViewType){
	            case 1:
	              this.initSortable(fileFieldId, elDiv.id, 'mediaitem', 'div', 'fileid', 'both');  
	             break;
	            case 2:
	              this.initSortable(fileFieldId, elDiv.id, 'docitem', 'div', 'fileid', 'vertical');  
	             break;
	            }
	        myCore.removeBusyClass(elDiv.id);	
	        }.bind(this)
	      });
          }          
        }
      }.bind(this));
    }    
  },
  
  /**
   * loadContactFieldsContent
   * @param string strType
   */
  loadContactFieldsContent: function(){    
    $$('#genFormContainer .contact').each(function(elDiv){    
      if($(elDiv.id)){          
        var fieldId = elDiv.id.substring(elDiv.id.indexOf('_')+1);
        if($(fieldId).value != ''){
          myCore.addBusyClass(elDiv.id);            
          new Ajax.Updater(elDiv.id, '/zoolu/cms/page/getcontacts', {
            parameters: { 
              contactIds: $(fieldId).value,
              fieldId: fieldId 
            },
            evalScripts: true,
            onComplete: function() {
              myCore.removeBusyClass(elDiv.id);                
            }.bind(this)
          });
        }          
      }
    }.bind(this));
  },  
  
  /**
   * writeMetaInfos
   */
  writeMetaInfos: function(){
    
    var strOutput = '';
    
    if($('divMetaInfos') && $('divMetaInfos').innerHTML != ''){
      strOutput = $('divMetaInfos').innerHTML;
      if($('divWidgetMetaInfos')){
        $('divWidgetMetaInfos').innerHTML = strOutput;
        $('divMetaInfos').innerHTML = '';
        return true;
      }
    }    
    return false;    
  },
  
  /**
   * getAddMediaOverlay
   */
  getAddMediaOverlay: function(areaId){    
    $(this.updateOverlayContainer).innerHTML = '';
    myCore.putCenter('overlayGenContentWrapper');
    $('overlayGenContentWrapper').show();    
    if($(areaId)){
      new Ajax.Updater(this.updateOverlayContainer, '/zoolu/cms/overlay/media', { 
        evalScripts: true,
        onComplete: function(){
          myCore.putOverlayCenter('overlayGenContentWrapper');
          myOverlay.areaId = areaId;
        } 
      });
    }    
  },
  
  /**
   * getAddDocumentOverlay
   */
  getAddDocumentOverlay: function(areaId){    
    $(this.updateOverlayContainer).innerHTML = '';
    myCore.putCenter('overlayGenContentWrapper');
    $('overlayGenContentWrapper').show();    
    if($(areaId)){
      new Ajax.Updater(this.updateOverlayContainer, '/zoolu/cms/overlay/document', { 
        evalScripts: true,
        onComplete: function(){
          myCore.putOverlayCenter('overlayGenContentWrapper');
          myOverlay.areaId = areaId;
        } 
      });
    }    
  },
  
  /**
   * getAddPageTreeOverlay
   */
   getAddPageTreeOverlay: function(areaId){    
    $(this.updateOverlayContainer).innerHTML = '';
    myCore.putCenter('overlayGenContentWrapper');
    $('overlayGenContentWrapper').show();    
    if($(areaId)){
      var fieldname = areaId.substring(areaId.indexOf('_')+1);
      new Ajax.Updater(this.updateOverlayContainer, '/zoolu/cms/overlay/pagetree', { 
        parameters: { portalId: myNavigation.rootLevelId,
                      itemAction: 'myOverlay.addPageToListArea',
                      pageIds: $(fieldname).value},
        evalScripts: true,
        onComplete: function(){
          myCore.putOverlayCenter('overlayGenContentWrapper');
          myOverlay.areaId = areaId;
        } 
      });
    }    
  },
  
  /**
   * getAddContactOverlay
   */
  getAddContactOverlay: function(areaId){    
    $(this.updateOverlayContainer).innerHTML = '';
    myCore.putCenter('overlayGenContentWrapper');
    $('overlayGenContentWrapper').show();    
    if($(areaId)){
      new Ajax.Updater(this.updateOverlayContainer, '/zoolu/cms/overlay/contact', { 
        evalScripts: true,
        onComplete: function(){
          myCore.putOverlayCenter('overlayGenContentWrapper');
          myOverlay.areaId = areaId;
        } 
      });
    }    
  },
  
  /**
   * getLinkedPageOverlay
   */
  getLinkedPageOverlay: function(fieldId){  
    $(this.updateOverlayContainer).innerHTML = '';
    $('overlayGenContentWrapper').setStyle({width: '560px'});

    myCore.putCenter('overlayGenContentWrapper');
    $('overlayGenContentWrapper').show();    
    if($(fieldId)){
      new Ajax.Updater(this.updateOverlayContainer, '/zoolu/cms/overlay/pagetree', { 
        parameters: { portalId: myNavigation.rootLevelId },
        evalScripts: true,
        onComplete: function(){
          myCore.putOverlayCenter('overlayGenContentWrapper');
          myOverlay.fieldId = fieldId;
          //$('overlayBlack75').show();
        } 
      });
    }  
  },
  
  /**
   * removeItem
   */
  removeItem: function(fieldId, elementId, id){  
    if($(fieldId) && $(elementId)){     
      itemId = $(elementId).readAttribute('fileid');
      if(itemId == null){
        itemId = $(elementId).readAttribute('pageid');
      }
      if($(fieldId).value.indexOf('[' + itemId + ']') > -1){
        $(fieldId).value = $(fieldId).value.replace('[' + itemId + ']', '');
 
        // delete element out of field area (media, doc)
        $(elementId).fade({ duration: 0.5 });
        setTimeout('$(\''+elementId+'\').remove()', 500);
        if($('divMediaContainer_'+fieldId)) new Effect.Highlight('divMediaContainer_'+fieldId, {startcolor: '#ffd300', endcolor: '#ffffff'});
        if($('divDocumentContainer_'+fieldId)) new Effect.Highlight('divDocumentContainer_'+fieldId, {startcolor: '#ffd300', endcolor: '#ffffff'});
        if($('divInternalLinksContainer_'+fieldId)) new Effect.Highlight('divInternalLinksContainer_'+fieldId, {startcolor: '#ffd300', endcolor: '#ffffff'});
        
        // display deleted element in overlay (media, doc)
        if($('olMediaItem'+id)) $('olMediaItem'+id).appear({ duration: 0.5 });
        if($('olDocItem'+id)) $('olDocItem'+id).appear({ duration: 0.5 });
        if($('olPageItem'+id)) $('olPageItem'+id).appear({ duration: 0.5 });
      }    
    }    
  },
  
  /**
   * toggleFieldsBox
   */
  toggleFieldsBox: function(elementId){
    
    if($('fieldsbox'+elementId)){
      $('fieldsbox'+elementId).toggle();

      if($('pointer'+elementId).hasClassName('closed')){
        $('pointer'+elementId).removeClassName('closed');
        $('pointer'+elementId).addClassName('opened');
      }else{
        $('pointer'+elementId).removeClassName('opened');
        $('pointer'+elementId).addClassName('closed');
      }
      
      if($('editbox'+elementId).hasClassName('editbox')){
        $('editbox'+elementId).removeClassName('editbox');
        $('editbox'+elementId).addClassName('editbox-closed');
      }else{
        $('editbox'+elementId).removeClassName('editbox-closed');
        $('editbox'+elementId).addClassName('editbox');
      }
      
      if($('cornerbl'+elementId).hasClassName('cornerbl')){
        $('cornerbl'+elementId).removeClassName('cornerbl');
        $('cornerbl'+elementId).addClassName('cornerbl-closed');
      }else{
        $('cornerbl'+elementId).removeClassName('cornerbl-closed');
        $('cornerbl'+elementId).addClassName('cornerbl');
      }

      if($('editbox'+elementId).hasClassName('configbox')){
        $('editbox'+elementId).removeClassName('configbox');
        $('editbox'+elementId).addClassName('configbox-closed');
      }
      else if($('editbox'+elementId).hasClassName('configbox-closed')){
        $('editbox'+elementId).removeClassName('configbox-closed');
        $('editbox'+elementId).addClassName('configbox');
      }     
    } 
  },
  
  /**
   * changeTemplate
   */
  changeTemplate: function(newTemplateId){
    
    $('divTemplate'+newTemplateId).addClassName('busy');
    
    // loader
    this.getFormSaveLoader();
      
    new Ajax.Updater(this.updateContainer, '/zoolu/cms/page/changeTemplate', {
      parameters: {
        newTemplateId: newTemplateId, 
        templateId: $F('templateId'),
        formId: $F('formId'),
        formVersion: $F('formVersion'),
        formTypeId: $F('formTypeId'),
        id: $F('id'),
        languageId: $F('languageId'),
        currLevel: $F('currLevel'),
        rootLevelId: $F('rootLevelId'),
        parentFolderId: $F('parentFolderId'),
        elementType: $F('elementType')                   
      },
      evalScripts: true,
      onComplete: function() {    
        
        if($F('rootLevelId') != '' && $F('rootLevelId') > 0){
          myNavigation.updateNavigationLevel();
        }                    
        //saved
        this.getFormSaveSucces();
        // load medias
        this.loadFileFieldsContent('media');
        // load documents
        this.loadFileFieldsContent('document');
        // load contacts
        this.loadContactFieldsContent();
      }.bind(this)
    });
      
  },
  
  /**
   * changeLanguage
   */
  changeLanguage: function(newLanguageId){
    
    myCore.addBusyClass(this.updateContainer);
    
    var intPosLastSlash = $(this.formId).readAttribute('action').lastIndexOf('/');
    var strAjaxActionBase = $(this.formId).readAttribute('action').substring(0, intPosLastSlash + 1);
                
    new Ajax.Updater(this.updateContainer, strAjaxActionBase + 'changeLanguage', {
      parameters: {
        templateId: $F('templateId'),
        formId: $F('formId'),
        formVersion: $F('formVersion'),
        formTypeId: $F('formTypeId'),
        id: $F('id'),
        languageId: newLanguageId,
        currLevel: $F('currLevel'),
        rootLevelId: $F('rootLevelId'),
        rootLevelTypeId: $F('rootLevelTypeId'),
        parentFolderId: $F('parentFolderId'),
        elementType: $F('elementType')
      },
      evalScripts: true,
      onComplete: function() {    
        myCore.removeBusyClass(this.updateContainer);
        this.writeMetaInfos();

        // load medias
        this.loadFileFieldsContent('media');
        // load documents
        this.loadFileFieldsContent('document');
        // load contacts
        this.loadContactFieldsContent();
      }.bind(this)
    });    
    
  },
  
  /**
   * addRegion
   */
  addRegion: function(regionId){
    
    var arrWidgets = [];
    $('Region_'+regionId+'_Instances').value.scan(/\[\d*\]/, function(widgets){ arrWidgets.push(widgets[0].gsub(/\[/, '').gsub(/\]/, ''))});
    widgetId = Number(arrWidgets[arrWidgets.length - 1]) + 1;
        
    var emptyRegion = $('divRegion_'+regionId+'_REPLACE_n');    
    var newRegion = new Element(emptyRegion.tagName);
     
    newRegion.update(emptyRegion.innerHTML.gsub(/REPLACE_n/, widgetId));
    
    newRegion['id'] = 'divRegion_'+regionId+'_'+widgetId;
    newRegion.addClassName(emptyRegion.className);
    
    arrWidgets.each(function(wId){ 
      if($('divAddRegion_'+regionId+'_'+wId)) $('divAddRegion_'+regionId+'_'+wId).show();
      if($('divRemoveRegion_'+regionId+'_'+wId)) $('divRemoveRegion_'+regionId+'_'+wId).show(); 
    });
    
    new Insertion.Before(emptyRegion, newRegion);        
    
    if(this.regionTexteditorObj[regionId]){
      this.regionTexteditorObj[regionId].each(function(elementId){        
        this.initTexteditor(elementId.gsub(/REPLACE_n/, widgetId));
      }.bind(this));
    }
    
    if(this.regionTitleObj[regionId]){
      this.regionTitleObj[regionId].each(function(elementId){
        this.initRegionTitleObserver(elementId.gsub(/REPLACE_n/, widgetId), regionId+'_'+widgetId);
      }.bind(this));
    }
            
    $('Region_'+regionId+'_Instances').value =  $('Region_'+regionId+'_Instances').value + '['+widgetId+']';
    
    this.createSortableRegion(regionId);
    
    var regionPos = $('divRegion_'+regionId+'_'+widgetId).cumulativeOffset();
    var containerPos = $('genFormContainer').cumulativeOffset();    
    $('genFormContainer').scrollTop = (regionPos.top - containerPos.top - 50);
    
    if($('editbox'+regionId+'_'+widgetId) && $('editbox'+regionId+'_'+widgetId).hasClassName('editbox-closed')){
      this.toggleFieldsBox(regionId+'_'+widgetId);
    }
  },
  
  /**
   * removeRegion
   */
  removeRegion: function(regionId, widgetId){
    
    $('divRegion_'+regionId+'_'+widgetId).remove();
    regEx = "["+widgetId+"]";    
    $('Region_'+regionId+'_Instances').value = $('Region_'+regionId+'_Instances').value.replace(regEx, '');
    var arrWidgets = [];
    $('Region_'+regionId+'_Instances').value.scan(/\[\d*\]/, function(widgets){ arrWidgets.push(widgets[0].gsub(/\[/, '').gsub(/\]/, ''))});
    
    if(arrWidgets.length == 1){
      if($('divRemoveRegion_'+regionId+'_'+arrWidgets[arrWidgets.length - 1])) $('divRemoveRegion_'+regionId+'_'+arrWidgets[arrWidgets.length - 1]).hide();
    }
    
    $('Region_'+regionId+'_Order').value = Sortable.serialize('divRegion_'+regionId);
  },
  
  /**
   * createSortableRegion
   */
  createSortableRegion: function(regionId) {
    SortableRegionId = 'divRegion_'+regionId;
    Sortable.destroy(SortableRegionId);
    if($(SortableRegionId)){      
      Sortable.create(SortableRegionId,{
            tag:'div',
            scroll:'genFormContainer',              
            only: 'sortablebox',
            handle:'editboxdrag',
            onUpdate: function(el){
              rId = el.id.replace('divRegion_', '');        
              $('Region_'+rId+'_Order').value = Sortable.serialize(el.id);
          }
      });
      
      $('Region_'+regionId+'_Order').value = Sortable.serialize(SortableRegionId);   
    }
  },
  
  /**
   * removeTinyMCEControl
   */
  removeTinyMCEControl: function(elementId){
    var arrElementIds = elementId.split('_');    
    if(arrElementIds.length == 3){
      regionId = arrElementIds[1];
      widgetId = arrElementIds[2];
      if(this.regionTexteditorObj[regionId]){
        this.regionTexteditorObj[regionId].each(function(elementId){
          tinyMCE.execCommand('mceRemoveControl', false, elementId.gsub(/REPLACE_n/, widgetId));        
        }.bind(this));
      }
    }
  },
  
  /**
   * addTinyMCEControl
   */
  addTinyMCEControl: function(elementId){
    var arrElementIds = elementId.split('_');    
    if(arrElementIds.length == 3){
      regionId = arrElementIds[1];
      widgetId = arrElementIds[2];
      if(this.regionTexteditorObj[regionId]){
        this.regionTexteditorObj[regionId].each(function(elementId){
          tinyMCE.execCommand('mceAddControl', false, elementId.gsub(/REPLACE_n/, widgetId));        
        }.bind(this));
      }
    }
  },
  
  /**
   * initTexteditor
   */
  initTexteditor: function(elementId){
    if($(elementId)){
      tinyMCE.init({
        // General options
        //mode : "specific_textareas",
        //editor_selector : "texteditor",
        mode : "exact",
        elements : elementId,            
        theme : "advanced",
        skin : "zoolu",
        debug : false,
        width : "100%",
        height : "150px",
        valid_elements : '*[*]',
     
        // plugins
        plugins : "safari,table,advimage,advlink,media,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,inlinepopups",
                    
        // Theme options
        theme_advanced_buttons1 : "bold,italic,strikethrough,|,bullist,numlist,|,justifyleft,justifycenter,justifyright,|,link,unlink,anchor,|,fullscreen,code,|,tablecontrols",
        //theme_advanced_buttons2 : "tablecontrols,|,image,media",
        theme_advanced_buttons2 : "",
        theme_advanced_buttons3 : "",
        theme_advanced_buttons4 : "",                
        theme_advanced_toolbar_location : "top",
        theme_advanced_toolbar_align : "left",
        theme_advanced_statusbar_location : "bottom",
        theme_advanced_resizing : true,
        theme_advanced_resize_horizontal : false,
        
        relative_urls : false                              
      });
    }
  },
  
  /**
   * addTexteditor
   */
  addTexteditor: function(elementId, regionId){
    //check if regionId is assigned 
    if(typeof(regionId) != 'undefined'){    
      if(!this.regionTexteditorObj[regionId]){
        this.regionTexteditorObj[regionId] = []
      }
      if(this.regionTexteditorObj[regionId].indexOf(elementId) == -1) this.regionTexteditorObj[regionId].push(elementId);
    }else{
      if(this.texteditorArray.indexOf(elementId) == -1) this.texteditorArray.push(elementId);
    }
  },
  
  /**
   * initRegionTitleObserver
   */
  initRegionTitleObserver: function(elementId, regionId){
    if($(elementId)){  
      $(elementId).observe('keyup', function(event){
        if($('spanRegionTitle_'+regionId)) $('spanRegionTitle_'+regionId).innerHTML = Event.element(event).value;
      });
    }
  },
  
  /**
   * addRegionTitle
   */
  addRegionTitle: function(elementId, regionId){
    //check if regionId is assigned 
    if(typeof(regionId) != 'undefined'){    
      if(!this.regionTitleObj[regionId]){
        this.regionTitleObj[regionId] = []
      }
      if(this.regionTitleObj[regionId].indexOf(elementId) == -1)  this.regionTitleObj[regionId].push(elementId);      
    }else{
      if(this.titleArray.indexOf(elementId) == -1) this.titleArray.push(elementId);
    }
  },
  
  /**
   * initSortable
   * Adds the scriptaculous sortable functionality to a container
   */
  initSortable: function(elementId, containerId, nodeClass, nodeTag, nodeName, constraint){
    if($(containerId) && nodeClass != '' && nodeTag != '' && nodeName != '' && constraint != ''){
    	if(constraint == 'both'){
    		constraint = false;
    	}
    	
      Sortable.create(containerId,{onChange: function(){
        var itemOrder = '';
        Sortable.sequence(containerId, {tag:nodeTag, name:nodeName}).each(function(id){
          itemOrder+='['+id+']';
        });
        $(elementId).value = itemOrder; 
      }, 
      elements:$$('#'+containerId+' .'+nodeClass),
      constraint:constraint,
      only:nodeClass
      });
    }
  },
  /**
   * edit the page Url
   */
  editUrl: function(elementId){
	if($(elementId) && $F(elementId) !== ''){
      $(elementId+'_UrlValue').innerHTML = '<input style="width:40%;" id="'+elementId+'_tmpUrl" type="text" value="'+$F(elementId+'_EditableUrl')+'"></input>';
      $(elementId+'_Controls').innerHTML = '&nbsp;<a href="#" onclick="myForm.addUrl(\''+elementId+'\'); return false;">OK</span>';
      $(elementId+'_tmpUrl').focus();
      this.intValidUrlObserver(elementId+'_tmpUrl', elementId);
	}
  },
  /**
   * add page url
   */
  addUrl: function(elementId){
    if($(elementId) && $F(elementId+'_tmpUrl') !== ''){
      $(elementId+'_EditableUrl').value = $F(elementId+'_tmpUrl');
      
      this.stopValidUrlObserver(elementId+'_tmpUrl');
      
      $(elementId+'_UrlValue').innerHTML = $F(elementId+'_tmpUrl');
      $(elementId+'_Controls').innerHTML = '&nbsp;<a href="#" onclick="myForm.editUrl(\''+elementId+'\'); return false;">Editieren</span>';
	}
  },
  /**
   * toggleUrlHistory
   */
  toggleUrlHistory: function(elementId){
    if($(elementId)){
    	
      $(elementId+'_ToggleUrlHistory').toggle();

      myCore.addBusyClass(elementId+'_ToggleUrlHistory');
          
      new Ajax.Updater(elementId+'_ToggleUrlHistory', '/zoolu/core/url/geturlhistory', {
        parameters:{ 
          elementId: elementId,
          pageId: $F('id'),
          languageId: $F('languageId')
        },
        evalScripts: true,
        onComplete: function(){
          myCore.removeBusyClass(elementId+'_ToggleUrlHistory');
   	    }.bind(this)
      }); 	
    }
  }, 
  
  /**
   * removeUrlHistoryEntry
   */
  removeUrlHistoryEntry: function(urlId, pageId, elementId){
    if(urlId && pageId && elementId){
      var Check = confirm("Alte Url unwiederruflich löschen?");
      
      if(Check == true){
        new Ajax.Request('/zoolu/core/url/removeUrlHistoryEntry', {
          parameters:{ 
            urlId: urlId,
            pageId: pageId
          },
          evalScripts: true,
          onComplete: function(){
        	  $(urlId+'_'+elementId).remove();
          }.bind(this)
        }); 
      }
    }
  },
  /**
   * initValidUrlObserver
   */
  intValidUrlObserver: function(inputId, elementId){
    if($(elementId) && $(inputId))
    {   
      $(inputId).observe('keypress', function(event){
    	var intCharCode = event.charCode;  
    	var intKeyCode = event.keyCode; 
       
    	if(intCharCode == 0 || intCharCode == undefined){
    	  // return	
    	  if(intKeyCode == 13){
    	    this.addUrl(elementId);
    	  }else{
            return true;
          }	
    	}else{
    	  // allow: capital letters || small letters || numbers || underscore || hyphen
          if(intCharCode >= 65 && intCharCode <= 90 || intCharCode >= 97 && intCharCode <= 123 || intCharCode >= 48 && intCharCode <= 57 || intCharCode == 95 || intCharCode == 45){
            return true;
          }else{
            Event.stop(event);
            return false;
          }
    	}
      }.bind(this));
    }
  },
  /**
   * stopValidUrlObserver
   */
  stopValidUrlObserver: function(elementId){
    if($(elementId))
    {   
      $(elementId).stopObserving();
    }
  },
  
   /**
   * initVideoChannelObserver
   */
  initVideoChannelObserver: function(elementId){
    if($(elementId+'TypeId')){
      $(elementId+'TypeId').observe('change', function(event){
	    if(Event.element(event).value != '' && Event.element(event).value > 0){
	      this.getVideoChannelSelect(elementId, Event.element(event).value);
	    }
      }.bind(this));
	
      if($F(elementId+'TypeId') != '' && $F(elementId+'TypeId') > 0){
	    channelUserId = ($(elementId+'User') ? $F(elementId+'User') : '');
		this.getVideoChannelSelect(elementId, $F(elementId+'TypeId'), channelUserId);
	  }
	}
  },
  
  /**
   * getVideoChannelSelect
   */
  getVideoChannelSelect: function(elementId, channelId, channelUserId){
    if($('div_'+elementId)){
    	
      $('div_'+elementId).show();
	  myCore.addBusyClass('div_'+elementId);
	  
	  if(typeof(channelUserId) == 'undefined'){       
	    channelUserId = null;
	  }else{
	    if($(elementId+'User') && $F(elementId+'User') != ''){
		  channelUserId = $F(elementId+'User');
		}else{
		  channelUserId = null;  
		}  
	  } 
		   
	  new Ajax.Updater('div_'+elementId, '/zoolu/core/video/getvideoselect', {
	  parameters: { 
	    elementId: elementId,
	    channelId: channelId,
		channelUserId: channelUserId,
	    value: $F(elementId)  
	  },
	  evalScripts: true,
	  onComplete: function(){
	    myCore.removeBusyClass('div_'+elementId);
	  }.bind(this)
	  });
	}
  },
  
  /**
   * initVideoChannelUserObserver
   */
  initVideoChannelUserObserver: function(elementId){
    if($(elementId+'User')){
      $(elementId+'User').observe('change', function(event){
        if(Event.element(event).value != ''){
          this.getVideoChannelSelect(elementId, $F(elementId+'TypeId'), Event.element(event).value);
        }
      }.bind(this));
    }
  },
  
  /**
   * initVideoResetSearchObserver
   */
  initVideoResetSearchObserver: function(elementId){
    if($(elementId+'SearchReset')){
      $(elementId+'SearchReset').observe('click', function(event){
    	if($F(elementId+'User')){
           this.getVideoChannelSelect(elementId, $F(elementId+'TypeId'), $F(elementId+'User'));
    	}
      }.bind(this));
    }
  },
  
  /**
   * getVideoSearchSelect
   */
  getVideoSearchSelect: function(elementId, channelId, searchString, channelUserId){
    if($('div_'+elementId)){
      myCore.addBusyClass('div_'+elementId);
      new Ajax.Updater('div_'+elementId, '/zoolu/core/video/getvideoselect',{ 
      parameters: { 
	    elementId: elementId,
	    channelId: channelId,
	    channelUserId: channelUserId,
	    searchString: searchString,
	    value: $F(elementId)
      },
      evalScripts: true,
      onComplete: function(){
        myCore.removeBusyClass('div_'+elementId);
      }.bind(this)
      });
  	}
  },
  
  /**
   * initVideoSearch
   */
  initVideoSearch: function(elementId) {
    if($(elementId+'Search')){
      $(elementId+'SearchButton').observe('click', function(event){ 
        if($F(elementId+'Search') != ''){
          this.getVideoSearchSelect(elementId, $F(elementId+'TypeId'), $F(elementId+'Search'),($(elementId+'User')? $F(elementId+'User'): '')); 
        }
      }.bind(this)); 
    }
  },
  
  /**
   * selectVideo
   */
  selectVideo: function(elementId, videoId){
    if($(elementId)){
      if($(elementId+'SelectedService') && $(elementId+'User') && $(elementId+'TypeId')){ 	  
    	  
	    var intIndexType = $(elementId+'TypeId').selectedIndex;
	    var serviceName = $(elementId+'TypeId').options[intIndexType].text;
	    var intIndexUser = $(elementId+'User').selectedIndex;
	    var serviceUser = $(elementId+'User').options[intIndexUser].text;
	    
	    $(elementId).value = videoId;
	    $(elementId+'Thumb').value = $F('thumb_'+elementId+'_'+videoId);
	    $(elementId+'TypeCur').value = $F(elementId+'TypeId');
		$(elementId+'UserCur').value = $F(elementId+'User');
			  
        $(elementId+'SelectedService').update(serviceName+'/'+serviceUser);
        $('div_selected'+elementId).update($('div_'+elementId+'_'+videoId).innerHTML);      
        $('div_selected'+elementId).down('.buttonSelectVideo').setStyle({display:'none'});
        $('div_selected'+elementId).down('.buttonUnselectVideo').setStyle({display:'inline'});
      }
	}
  },
  
  /**
   * getSelectedVideo
   */
  getSelectedVideo: function(elementId){
	    
	  if($(elementId+'SelectedContainer') && $F(elementId+'TypeCur') != '' && $F(elementId) != '' && $F(elementId+'UserCur') != '') {
	
		  myCore.addBusyClass('div_selected'+elementId);
	  		
		  new Ajax.Updater('div_'+elementId, '/zoolu/core/video/getselectedvideo', {
		  parameters: { 
			  elementId: elementId,
			  channelId: $F(elementId+'TypeCur'),
			  channelUserId: $F(elementId+'UserCur'),
			  value: $F(elementId)
		  },
		  evalScripts: true,
		  onComplete: function(){
			  myCore.removeBusyClass('div_selected'+elementId);
		  }.bind(this)
		  });
	 }
  },

  /**
   * unselect a selected video
   */
  unselectVideo: function(elementId, videoId){
	  if($(elementId)){
		  if($(elementId)){
			  $(elementId).value = '';
			  $(elementId+'Thumb').value = '';
			  $('div_selected'+elementId).update('');
			  $(elementId+'SelectedService').update('');
		  }
	  }
  },
  
  /**
   * writePublishDate
   */
  writePublishDate: function(){
    var year, monthnum, day, hour, minute;
    var monthShortName;
    
    if($('publishDate')){
	    // date
	    if($('publishYear')){
	      year = $('publishYear').getValue(); 
	    } 
	    
	    if($('publishMonth')){
	      var w = $('publishMonth').selectedIndex;
        monthShortName = $('publishMonth').options[w].text;
	      monthnum = $('publishMonth').getValue();
	    } 
	    
	    if($('publishDay')){
	      day = $('publishDay').getValue();
	      if(day.length < 2){
          day = '0' + day;
        }
	    } 
	    
	    // time
	    if($('publishHour')){
	      hour = $('publishHour').getValue();
	      if(hour.length < 2){
	        hour = '0' + hour;
	      }
	    } 
	    
	    if($('publishMinute')){
	      minute = $('publishMinute').getValue();
	      if(minute.length < 2){
          minute = '0' + minute;
        }
	    } 
	    	    
	    // write to hidden field in form
	    $('publishDate').setValue(year+'-'+monthnum+'-'+day+' '+hour+':'+minute+':00');
	    
	    // write output
	    $('divPublishDate').innerHTML = day+'. '+monthShortName+'. '+year+', '+hour+':'+minute;
	    new Effect.Highlight('divPublishDate', {startcolor: '#ffd300', endcolor: '#e4e4e4'});
	    
	    this.togglePublishDate();
	  }       
  },
  
  /**
   * togglePublishDate
   */
  togglePublishDate: function(){
    if($('divPublishDateNew') && $('divPublishDateNew').style.display == 'none'){
      Effect.SlideDown('divPublishDateNew', { duration: 0.5 });
    }else{
      Effect.SlideUp('divPublishDateNew', { duration: 0.5 });
    }
  },
  
  /**
   * toggleTemplateChooser
   */
  toggleTemplateChooser: function(){
    
    if($('divAllTemplates') && $('divAllTemplates').style.display == 'none'){
      Effect.SlideDown('divAllTemplates'); //$('divAllTemplates').show();
    }else{
      Effect.SlideUp('divAllTemplates'); //$('divAllTemplates').hide();
    }
  },
  
  /**
   * selectTab
   */
  selectTab: function(tabId){
    if($('divTab_'+this.activeTabId)){
      $('divTab_'+this.activeTabId).hide();
      $('tabNavItem_'+this.activeTabId).removeClassName('selected');
    }
    $('divTab_'+tabId).show();
    $('tabNavItem_'+tabId).addClassName('selected');
    this.setActiveTab(tabId);
  },
  
  /**
   * selectTab
   */
  setActiveTab: function(tabId){
    this.activeTabId = tabId;    
  },
  
  /**
   * getFormSaveSucces
   */
  getFormSaveSucces: function(){
    $('divFormSaveSucces').show();
    $('divFormSaveLoader').hide();
    $('divFormSaveSucces').fade({ duration: 2 });
  },
  
  /**
   * getFormSaveError
   */
  getFormSaveError: function(){
    $('divFormSaveError').show();
    $('divFormSaveLoader').hide();
    $('divFormSaveError').fade({ duration: 2 });
  },
  
  /**
   * getFormDeleteSucces
   */
  getFormDeleteSucces: function(){
    $('divFormDeleteSucces').show();
    $('divFormSaveLoader').hide();
    $('divFormDeleteSucces').fade({ duration: 2 });
  },
  
  /**
   * getFormSaveLoader
   */
  getFormSaveLoader: function(){
    $('divFormSaveLoader').show();    
  },
  
  /**
   * getFormSaveLoader
   */
  cancleFormSaveLoader: function(){
    $('divFormSaveLoader').hide();    
  }
});