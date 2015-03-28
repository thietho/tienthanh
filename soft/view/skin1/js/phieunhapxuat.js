function PhieuNhapXuat()
{
	this.index = 0;
	this.addRow = function(id,mediaid,code,title,soluong,madonvi,giatien,giamgia,phantramgiamgia)
	{
		
		var row = '<tr id="row'+ this.index +'">';
		row +='<td><input type="hidden" id="nhapkhoid-'+ this.index +'" name="nhapkhoid['+ this.index +']" value="'+ id +'" /><input type="hidden" id="mediaid-'+ this.index +'" name="mediaid['+ this.index +']" value="'+ mediaid +'" /><input type="hidden" id="title-'+ this.index +'" name="title['+ this.index +']" value="'+ title +'" />'+ title +'</td>';
		
		row +='<td class="number"><input type="text" id="soluong-'+ this.index +'" name="soluong['+ this.index +']" value="'+soluong+'" class="text number short soluong" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><select mediaid="'+mediaid+'" class="madonvi" id="madonvi-'+ this.index +'" name="dlmadonvi['+ this.index +']" value="'+madonvi+'" ref="'+ this.index +'"></select></td>';
		row +='<td class="number"><input type="text" id="giatien-'+ this.index +'" name="giatien['+ this.index +']" value="'+giatien+'" class="text number short giatien" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="phantramgiamgia-'+ this.index +'" name="phantramgiamgia['+ this.index +']" value="'+phantramgiamgia+'" class="text number short phantramgiamgia" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="giamgia-'+ this.index +'" name="giamgia['+ this.index +']" value="'+ giamgia +'" class="text number short giamgia" ref="'+ this.index +'"/></td>';
		
		row += '<td class="number thanhtien" id="thanhtien-'+ this.index +'"></td>';
		row +='<td><input type="button" class="button" value="Xóa" onclick="objdl.removeRow('+ this.index +')"/></td>';
		row+='</tr>'
		$('#nhapkhonguyenlieu').append(row);
		var str = '#madonvi-'+ this.index;
		var curpos = this.index;
		
		$('.madonvi').change(function(e) {
			var pos = $(this).attr('ref');
			
			objdl.getPrice(pos,mediaid,this.value);
			
        });
		
		$.getJSON("?route=core/media/getListDonVi&mediaid="+ mediaid,
			function(data){
				html = "";
				for(i in data)
				{
					//alert(data[i].madonvi)
					html += '<option value="'+data[i].madonvi+'">'+data[i].tendonvitinh+'</option>';
				}
				$(str).html(html);
				$(str).val(madonvi);
				if(id == 0)
					objdl.getPrice(curpos,mediaid,madonvi);
			});
		
		objdl.tinhtong(this.index);
		this.index++;
		$('.soluong').keyup(function(e) {
            var pos = $(this).attr('ref');
			objdl.tinhtong(pos);
			
        });
		$('.giatien').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
			var giamgia = giatien * phantramgiamgia/100;
			$('#giamgia-'+pos).val(formateNumber(giamgia))
			objdl.tinhtong(pos);
        });
		$('.giamgia').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var giamgia = Number(stringtoNumber($('#giamgia-'+pos).val()));
			var phantramgiamgia = giamgia/giatien *100;
			$('#phantramgiamgia-'+pos).val(formateNumber(phantramgiamgia))
			objdl.tinhtong(pos);
        });
		$('.phantramgiamgia').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
			var giamgia = giatien * phantramgiamgia/100;
			$('#giamgia-'+pos).val(formateNumber(giamgia))
			objdl.tinhtong(pos);
        });
		numberReady();
	}
	this.addGroup = function(id,title,soluong,madonvi,giatien,giamgia,phantramgiamgia)
	{
		var row = '<tr id="row'+ this.index +'">';
		row +='<td><input type="hidden" id="nhapkhoid-'+ this.index +'" name="nhapkhoid['+ this.index +']" value="'+ id +'" /><input type="text" class="text" style="width:100%" id="title-'+ this.index +'" name="title['+ this.index +']" value="'+ title +'" /></td>';
		
		row +='<td class="number"><input type="text" id="soluong-'+ this.index +'" name="soluong['+ this.index +']" value="'+soluong+'" class="text number short soluong" ref="'+ this.index +'"/></td>';
		row +='<td><input type="text" id="dlmadonvi-'+ this.index +'" name="dlmadonvi['+ this.index +']" value="'+ madonvi +'" class="text short" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="giatien-'+ this.index +'" name="giatien['+ this.index +']" value="'+giatien+'" class="text number short giatien" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="phantramgiamgia-'+ this.index +'" name="phantramgiamgia['+ this.index +']" value="'+phantramgiamgia+'" class="text number short phantramgiamgia" ref="'+ this.index +'"/></td>';
		row +='<td class="number"><input type="text" id="giamgia-'+ this.index +'" name="giamgia['+ this.index +']" value="'+ giamgia +'" class="text number short giamgia" ref="'+ this.index +'"/></td>';
		
		row += '<td class="number thanhtien" id="thanhtien-'+ this.index +'"></td>';
		row +='<td><input type="button" class="button" value="Xóa" onclick="objdl.removeRow('+ this.index +')"/></td>';
		row+='</tr>';
		row+='<div>ssswefgwefergerg wefgwerf efw èwerfwesdfgrwegfewgw</div>';
		$('#nhapkhonguyenlieu').append(row);
		
		objdl.tinhtong(this.index);
		this.index++;
		$('.soluong').keyup(function(e) {
            var pos = $(this).attr('ref');
			objdl.tinhtong(pos);
			
        });
		$('.giatien').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
			var giamgia = giatien * phantramgiamgia/100;
			$('#giamgia-'+pos).val(formateNumber(giamgia))
			objdl.tinhtong(pos);
        });
		$('.giamgia').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var giamgia = Number(stringtoNumber($('#giamgia-'+pos).val()));
			var phantramgiamgia = giamgia/giatien *100;
			$('#phantramgiamgia-'+pos).val(formateNumber(phantramgiamgia))
			objdl.tinhtong(pos);
        });
		$('.phantramgiamgia').keyup(function(e) {
            var pos = $(this).attr('ref');
			var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
			var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
			var giamgia = giatien * phantramgiamgia/100;
			$('#giamgia-'+pos).val(formateNumber(giamgia))
			objdl.tinhtong(pos);
        });
		numberReady();
	}
	this.getPrice = function(pos,mediaid,madonvi)
	{
		
		$.getJSON("?route=core/media/getMedia&col=mediaid&val="+ mediaid,
			function(data)
			{
				
				var saleprice = $.parseJSON(data.medias[0].saleprice);
				price = saleprice[madonvi];
				
				if(Number(price) == 0 || price == undefined)
				{
					price = data.medias[0].price;
				}
				$('#giatien-'+pos).val(price);
				
				numberReady();
			});
	}
	this.removeRow = function(pos)
	{
		var nhapkhoid = $('#nhapkhoid-'+pos).val();
		$('#delnhapkho').val(nhapkhoid+ "," +$('#delnhapkho').val());
		$('#row'+pos).remove();
		this.tinhtong(pos);
	}
	this.tinhtong = function(pos)
	{
		var soluong = Number(stringtoNumber($('#soluong-'+pos).val()));
		var giatien = Number(stringtoNumber($('#giatien-'+pos).val()));
		var giamgia = Number(stringtoNumber($('#giamgia-'+pos).val()));
		var phantramgiamgia = Number(stringtoNumber($('#phantramgiamgia-'+pos).val()));
		var thanhtien = soluong*(giatien-giamgia);
		
		$('#thanhtien-'+pos).html(formateNumber(thanhtien));
		var sum = 0;
		$('.thanhtien').each(function(index, element) {
            sum += Number(stringtoNumber($(this).html()));
        });
		var thuphi = Number(stringtoNumber($('#thuphi').val()));
		sum+=thuphi;
		$('#tongcong').html(formateNumber(sum));
		$('#tongtien').val(sum);
		var thanhtoan = Number(stringtoNumber($('#thanhtoan').val()));
		$('#congno').val(sum - thanhtoan);
		$('#lbl-congno').html(formateNumber(sum - thanhtoan));
		var sum = 0;
		$('.soluong').each(function(index, element) {
			sum += Number(stringtoNumber(this.value));
		});
		$('#sumsoluong').html(formateNumber(sum));
	}
	this.printPX = function(listid)
	{
		openDialog("?route=quanlykho/phieuxuat/printlist&listid="+listid+"&opendialog=print",800,500)
	}
	this.printPXDisCount = function(listid)
	{
		openDialog("?route=quanlykho/phieuxuat/printlist&listid="+listid+"&opendialog=print&show=giamgia",800,500)
	}
	this.viewPX = function(id,callback)
	{
		
		var eid = "popupviewphieu";
		$('body').append('<div id="'+eid+'" style="display:none"></div>');
		$("#"+eid).attr('title','Phiếu bán hàng');
		$( "#"+eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 1000,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$('#'+eid).remove();
					if(callback!="")
					{
						setTimeout(callback,100);
					}
				},
			buttons: {
				
				'In':function()
				{
					openDialog("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=print",800,500);
				},
				'In giảm giá':function()
				{
					openDialog("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=print&show=giamgia",800,500);
				},
				'Đóng': function() 
				{
					
					$( this ).dialog( "close" );
					
				},
			}
		});
		$("#"+eid).dialog("open");
		$("#"+eid).html(loading);
		$("#"+eid).load("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=true",function(){
			
		});
	}
	
	this.viewPN = function(id)
	{
		var eid = "popupviewphieu";
		$('body').append('<div id="'+eid+'" style="display:none"></div>');
		$("#"+eid).attr('title','Phiếu nhập kho');
		$( "#"+eid ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 1000,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$('#'+eid).remove();
				},
			buttons: {
				
				'In':function()
				{
					openDialog("?route=quanlykho/phieunhap/view&id="+id+"&opendialog=print",800,500)
					
				},
				'In giảm giá':function()
				{
					openDialog("?route=quanlykho/phieunhap/view&id="+id+"&opendialog=print&show=giamgia",800,500)
					
				},
				'Đóng': function() 
				{
					
					$( this ).dialog( "close" );
					
				},
			}
		});
		$("#"+eid).dialog("open");
		$("#"+eid).html(loading);
		$("#"+eid).load("?route=quanlykho/phieunhap/view&id="+id+"&opendialog=true",function(){
			
		});
	}
	
	this.importDetail = function()
	{
		$('body').append('<div id="history_form" style="display:none"></div>');
		var eid = "#history_form";
		
		
		$(eid).attr('title','Import dữ liệu');
			$( eid ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				close:function()
					{
						$(eid).remove();
					},
				buttons: {
				
					'Import':function()
					{
						//$('#history_form').scrollTop(500);
						//$('.item').removeClass('itemselected');
						//$('#history_form').scrollTop(0)
						//alert(i)
						//var k = 2;
						//pro.postProduct(k);
						
					},
					'Đóng': function() 
					{
						
						$(eid).dialog( "close" );
						window.location.reload();
					},
				}
				
			});
		
			$(eid).dialog("open");
			$(eid).html(loading);
			$(eid).load("?route=module/product/import&dialog=true",function(){
				
			});
	}
	this.save = function(type)
	{
		
	}
	this.getProbyMediaId = function(str)
	{
		
		arr = str.split("-");
		$.getJSON("?route=core/media/getMedia&col=mediaid&val="+encodeURI(arr[0]),function(data)
		{			
			var giagiam = 0;
			if(data.medias[0].pricepromotion > 0)
			{
				giagiam = data.medias[0].price - data.medias[0].pricepromotion;
			}
			objdl.addRow(0,data.medias[0].mediaid,data.medias[0].code,data.medias[0].productName,1,data.medias[0].madonvi,data.medias[0].price,giagiam,data.medias[0].discountpercent);
			//alert($('#txt_ref').val());
			$('#txt_ref').val('');
		});
	}
}

var objdl = new PhieuNhapXuat();