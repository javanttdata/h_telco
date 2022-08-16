ACC.storefinder = {

	_autoload: [
		["init", $(".js-store-finder").length != 0],
		["bindStoreChange", $(".js-store-finder").length != 0],
		["bindSearch", $(".js-store-finder").length != 0],
		"bindPagination"
	],
	
	storeData:"",
	storeId:"",
	coords:{},
	storeSearchData:{},

	createListItemHtml: function (data,id){

		var $rdioEl = $("<input>").addClass("js-store-finder-input")
			.attr("type","radio")
			.attr("name","storeNamePost")
			.attr("id","store-filder-entry-" + String(id))
			.attr("data-id",String(id))
			.val(ACC.storefinder.sanitizeString(data.displayName));


		var $spanInfo = $("<span>").addClass("entry__info")
			.append($("<span>").addClass("entry__name").text(String(data.displayName)))
			.append($("<span>").addClass("entry__address").text(String(data.line1 + ' ' + data.line2)))
			.append($("<span>").addClass("entry__city").text(String(data.town)));


		var $spanDistance = $("<span>").addClass("entry__distance")
			.append($("<span>").text(String(data.formattedDistance)));

		var $label = $("<label>").addClass("js-select-store-label")
			.attr("for","store-filder-entry-" + String(id))
			.append($spanInfo)
			.append($spanDistance);

		return $("<li>").addClass("list__entry")
			.append($rdioEl)
			.append($label)
	},

	refreshNavigation: function (){
		data = ACC.storefinder.storeData

		var $storeList = $(".js-store-finder-navigation-list");
		$storeList.empty();

		if(data){
			for(i = 0;i < data["data"].length;i++){
				$storeList.append(ACC.storefinder.createListItemHtml(data["data"][i],i));
			}

			// select the first store
			var firstInput= $(".js-store-finder-input")[0];
			$(firstInput).click();
		}


		var page = ACC.storefinder.storeSearchData.page;
		$(".js-store-finder-pager-item-from").text(page*10+1);

		var to = ((page*10+10)>ACC.storefinder.storeData.total)? ACC.storefinder.storeData.total : page*10+10 ;
		$(".js-store-finder-pager-item-to").text(to);
		$(".js-store-finder-pager-item-all").text(ACC.storefinder.storeData.total);
		$(".js-store-finder").removeClass("show-store");


	},


	bindPagination:function ()
	{



		$(document).on("click",".js-store-finder-details-back",function(e){
			e.preventDefault();

			$(".js-store-finder").removeClass("show-store");

		})



		$(document).on("click",".js-store-finder-pager-prev",function(e){
			e.preventDefault();
			var page = ACC.storefinder.storeSearchData.page;
			ACC.storefinder.getStoreData(page-1)
			checkStatus(page-1);
		})

		$(document).on("click",".js-store-finder-pager-next",function(e){
			e.preventDefault();
			var page = ACC.storefinder.storeSearchData.page;
			ACC.storefinder.getStoreData(page+1)
			checkStatus(page+1);
		})

		function checkStatus(page){
			if(page==0){
				$(".js-store-finder-pager-prev").attr("disabled","disabled")
			}else{
				$(".js-store-finder-pager-prev").removeAttr("disabled")
			}

			if(page == Math.floor(ACC.storefinder.storeData.total/10)){
				$(".js-store-finder-pager-next").attr("disabled","disabled")
			}else{
				$(".js-store-finder-pager-next").removeAttr("disabled")
			}
		}

	},

	bindStoreChange:function()
	{
		$(document).on("change",".js-store-finder-input",function(e){
			e.preventDefault();



			storeData=ACC.storefinder.storeData["data"];

			var storeId=$(this).data("id");

			var $ele = $(".js-store-finder-details");



			$.each(storeData[storeId],function(key,value){
				if(key=="image"){
					if(value!=""){
						$ele.find(".js-store-image").html(('<img src="'+ACC.storefinder.sanitizeString(value)+'" alt="" />'));
					}else{
						$ele.find(".js-store-image").html('');
					}
				}else if(key=="productcode"){
					$ele.find(".js-store-productcode").val(value);
				}
				else if(key=="openings"){
					if(value!=""){
						var $oele = $ele.find(".js-store-"+key);
						$oele.empty();
						$.each(value,function(key2,value2){
							$oele.append($("<dt>").text(ACC.storefinder.sanitizeString(key2)));
							$oele.append($("<dd>").text(ACC.storefinder.sanitizeString(value2)));
						});


					}else{
						$ele.find(".js-store-"+key).html('');
					}

				}
				else if(key=="specialOpenings"){}
				else if(key=="features"){
					var $features = $ele.find(".js-store-"+key);
					$features.empty();
					$.each(value,function(key2,value2){
						$features.append($("<li>").text(ACC.storefinder.sanitizeString(value2)));
					});

				}
				else{
					if(value!=""){
						$ele.find(".js-store-"+key).text(value);
					}else{
						$ele.find(".js-store-"+key).html('');
					}
				}

			})


			ACC.storefinder.storeId = storeData[storeId];
			ACC.storefinder.initGoogleMap();

		})

		$(document).on("click",".js-select-store-label",function(e){
			$(".js-store-finder").addClass("show-store")
		})

		$(document).on("click",".js-back-to-storelist",function(e){
			$(".js-store-finder").removeClass("show-store")
		})

	},



	initGoogleMap:function(){

		if($(".js-store-finder-map").length > 0){
			ACC.global.addGoogleMapsApi("ACC.storefinder.loadGoogleMap");
		}
	},

	loadGoogleMap: function(){

		storeInformation = ACC.storefinder.storeId;

		if($(".js-store-finder-map").length > 0)
		{
			$(".js-store-finder-map").attr("id","store-finder-map")
			var centerPoint = new google.maps.LatLng(storeInformation["latitude"], storeInformation["longitude"]);

			var mapOptions = {
				zoom: 13,
				zoomControl: true,
				panControl: true,
				streetViewControl: false,
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				center: centerPoint
			}

			var map = new google.maps.Map(document.getElementById("store-finder-map"), mapOptions);

			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(storeInformation["latitude"], storeInformation["longitude"]),
				map: map,
				title: storeInformation["name"],
				icon: "https://maps.google.com/mapfiles/marker" + 'A' + ".png"
			});
			var infowindow = new google.maps.InfoWindow({
				content: storeInformation["name"],
				disableAutoPan: true
			});
			google.maps.event.addListener(marker, 'click', function (){
				infowindow.open(map, marker);
			});
		}

	},


	bindSearch:function(){

		$(document).on("submit",'#storeFinderForm', function(e){
			e.preventDefault()
			var q = $(".js-store-finder-search-input").val();

			if(q.length>0){
				ACC.storefinder.getInitStoreData(q);
			}else{
				if($(".js-storefinder-alert").length<1){
					var emptySearchMessage = $(".btn-primary").data("searchEmpty")
					$(".js-store-finder").hide();
					$("#storeFinder").before('<div class="global-alerts"><div class="js-storefinder-alert alert alert-danger alert-dismissable" ><button class="close closeAccAlert" type="button" data-dismiss="alert" aria-hidden="true">×</button>' + emptySearchMessage + '</div>');
				}
			}
		})


		$(".js-store-finder").hide();
		$(document).on("click",'#findStoresNearMe', function(e){
			e.preventDefault()
			ACC.storefinder.getInitStoreData(null,ACC.storefinder.coords.latitude,ACC.storefinder.coords.longitude);
		});
		$(document).on("click",'.closeAccAlert', function(e){
			e.preventDefault()
		    $(".global-alerts").remove();
		});
	},


	getStoreData: function(page){
		ACC.storefinder.storeSearchData.page = page;
		url= $(".js-store-finder").data("url");
		$.ajax({
			url: url,
			data: ACC.storefinder.storeSearchData,
			type: "get",
			success: function (response){
				try{
					ACC.storefinder.storeData = $.parseJSON(response);
				} catch(error) {
					var emptySearchMessage = $(".btn-primary").data("searchEmpty");
					$(".js-store-finder").hide();
					$("#storeFinder").before('<div class="global-alerts"><div class="js-storefinder-alert alert alert-danger alert-dismissable" ><button class="close closeAccAlert" type="button" data-dismiss="alert" aria-hidden="true">×</button>' + emptySearchMessage + '</div></div>');
				}
				ACC.storefinder.refreshNavigation();
				if(ACC.storefinder.storeData.total < 10){
					$(".js-store-finder-pager-next").attr("disabled","disabled");
				}
			}
		});
	},

	getInitStoreData: function(q,latitude,longitude){
		$(".alert").remove();
		data ={
			"q":"" ,
			"page":0
		}
		if(q != null){
			data.q = q;
		}

		if(latitude != null){
			data.latitude = latitude;
		}

		if(longitude != null){
			data.longitude = longitude;
		}

		ACC.storefinder.storeSearchData = data;
		ACC.storefinder.getStoreData(data.page);
		$(".js-store-finder").show();
		$(".js-store-finder-pager-prev").attr("disabled","disabled")
		$(".js-store-finder-pager-next").removeAttr("disabled")
	},

	init:function(){
		$("#findStoresNearMe").attr("disabled","disabled");
		if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(
				function (position){
					ACC.storefinder.coords = position.coords;
					$('#findStoresNearMe').removeAttr("disabled");
				},
				function (error)
				{
					console.log("An error occurred... The error code and message are: " + error.code + "/" + error.message);
				}
			);
		}
	},
	sanitizeString: function (inputKey) {
		inputKey = inputKey.replace(/[^a-z0-9áéíóúñü \.,_=?/-]/gim, "");
		return inputKey.trim();
	}
};