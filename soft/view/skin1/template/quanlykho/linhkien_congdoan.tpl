<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?>Định lượng linh kiện trung gian</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/linhkien')"/>   
     	        <input type="hidden" name="malinhkien" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã linh kiện: <?php echo $item['malinhkien']?></label>
            	</p>
              	
                
                <p>
            		<label>Tên linh kiện: <?php echo $item['tenlinhkien']?></label>
            	</p>
               	<!--<p>
                
            		<label>Mã công đoạn</label><br />
					<input type="text" id="macongdoan" name="macongdoan" class="text" size=60 />
                    <input type="hidden" id="id" name="id"/>
            	</p>
                <p>
            		<label>Tên công đoạn</label><br />
					<input type="text" id="tencongdoan" name="tencongdoan" class="text" size=60/>
            	</p>
                <p>
            		<label>Thứ tự thực hiện</label><br />
					<input type="text" id="thututhuchien" name="thututhuchien" class="text number" size=20 />
            	</p>
               	<p>
            		<label>Định mức chỉ tiêu</label><br />
					<input type="text" id="dinhmucchitieu" name="dinhmucchitieu" class="text number" size=20 />
            	</p>
               	<p>
            		<label>Giá gia công</label><br />
					<input type="text" id="giagiacong" name="giagiacong" class="text number" size=20 />
            	</p>
               	<p>
            		<label>Định mức phế liệu</label><br />
					<input type="text" id="dinhmucphelieu" name="dinhmucphelieu" class="text number" size=20 />
            	</p>
                <p>
            		<label>Định mức phế phẩm</label><br />
					<input type="text" id="dinhmucphepham" name="dinhmucphepham" class="text number" size=20 />
            	</p>
                <p>
            		<label>Định mức hao hụt</label><br />
					<input type="text" id="dinhmuchaohut" name="dinhmuchaohut" class="text number" size=20 />
            	</p>
                <p>
            		<label>Định mức năng xuất</label><br />
					<input type="text" id="dinhmucnangxuat" name="dinhmucnangxuat" class="text number" size=20 />
            	</p>
                <p>
            		<label>Định mức phụ liệu</label><br />
					<input type="text" id="dinhmucphulieu" name="dinhmucphulieu" class="text number" size=20 />
            	</p>
                <p>
            		<label>Số lượng/kg</label><br />
					<input type="text" id="soluongtrenkg" name="soluongtrenkg" class="text number" size=20 />
            	</p>
                <p>
                	<label>Nguyên liệu sản xuất</label><br>
                    <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                    <input type="hidden" id="nguyenlieusanxuat" name="nguyenlieusanxuat">
                    <span id="tennguyenlieu"></span>
                    <input type="button" class="button" name="btnChonNguyenLieu" value="Chọn nguyên vật liệu" onClick="selcetNguyenLieu()">
                    <input type="button" class="button" name="btnUnChonNguyenLieu" value="Bỏ chọn" onClick="unSelcetNguyenLieu()">
                </p>
                <p>
                	<label>Thiết bị sản xuất chính</label><br>
                    <input type="hidden" id="selecttaisan" name="selecttaisan">
                    <input type="hidden" id="thietbisanxuatchinh" name="thietbisanxuatchinh">
                    <span id="tentaisan"></span>
                    <input type="button" class="button" name="btnChonTaiSan" value="Chọn tài sản" onClick="selcetTaiSan()">
                    <input type="button" class="button" name="btnUnChonTaiSan" value="Bỏ chọn" onClick="unSelcetTaiSan()">
                </p>
                <p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichu" name="ghichu"></textarea>
            	</p>-->
            </div>
            <div>
            	<table>
                	<thead>
                		<tr>
                        	<th>Mã công đoạn</th>
                            <th>Tên công đoạn</th>
                            <th>Thứ tự công đoạn</th>
                            <th>Nguyên liệu sản xuất</th>
                            <th>Thiết bị sản xuất</th>
                            <th>Định mức chỉ tiêu</th>
                            <th>Giá gia công</th>
                            <th>Định mức phế liệu</th>
                            <th>Định mức phế phẩm</th>
                            <th>Định mức hao hụt</th>
                            <th>Định mức năng xuất</th>
                            <th>Định mức phụ liệu</th>
                            <th>Số lượng/Kg</th>
                            <th>Ghi chú</th>
                            <th></th>
                    	</tr>
                    </thead>
                    <tbody id="listcongdoan">
                    	
                    </tbody>
                    
                </table>
                <input type="hidden" id="delcongdoans" name="delcongdoans" />
                <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="cd.newRow()">
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
var auto = new AutoComplete();
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/linhkien/savecongdoan", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/linhkien";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

//Cong doan
function CongDoan()
{
	this.index = 0;
	this.refresh = function()
	{
		$('input').change(function(e) {
			ar = this.id.split('-');
			var row= ar[1];
			$("#status-"+row).val('update');
			$('#row-'+row).css('background-color',"#F0F");
		});
		numberReady();
		auto.autocomplete();
	}
	this.getCongDoan = function(col,val,operator)
	{
		$.getJSON("?route=quanlykho/congdoan/getCongDoan&col="+col+"&val="+val+"&operator="+operator, 
				function(data) 
				{
					//var str = '<option value=""></option>';
					for( i in data.congdoans)
					{
						
						$("#listcongdoan").append(cd.createRowCongDoan(data.congdoans[i]));
						
					}
					cd.refresh()
				});
	}
	
	this.newRow =function()
	{
		var obj = new Object()
		obj.id='';
		obj.macongdoan='';
		obj.tencongdoan='';
		obj.thututhuchien='';
		obj.nguyenlieusanxuat='';
		obj.tennguyenlieusanxuat='';
		obj.thietbisanxuatchinh='';
		obj.tenthietbisanxuatchinh='';
		obj.dinhmucchitieu='';
		obj.giagiacong='';
		obj.dinhmucphelieu='';
		obj.dinhmucphepham='';
		obj.dinhmuchaohut='';
		obj.dinhmucnangxuat='';
		obj.dinhmucphulieu='';
		obj.soluongtrenkg='';
		obj.ghichu='';
		
		$("#listcongdoan").append(cd.createRowCongDoan(obj));
		cd.refresh()
	}
	
	this.createRowCongDoan = function(obj)
	{
		var id = '<input type="hidden" id="id-'+ this.index +'" name="id['+ this.index +']" value="'+obj.id+'" />';
		id += '<input type="hidden" id="status-'+ this.index +'" name="status['+ this.index +']" />';
		var btnXoa = '<input type="button" value="Xóa" class="button" onClick="cd.delRow('+this.index+')"/>';
		var btnXemQuaTrinh = '<input type="button" value="Xem quá trình biến đổi" class="button" onClick="cd.viewCongDoan(\''+obj.macongdoan+'\')"/>';
		var row = '';
		row+='					<tr id="row-'+ this.index +'">';
		row+='                    	<td><input type="text" id="macongdoan-'+ this.index +'" name="macongdoan['+ this.index +']" class="text" value="'+obj.macongdoan+'" /></td>';
		row+='                      <td><input type="text" id="tencongdoan-'+ this.index +'" name="tencongdoan['+ this.index +']" class="text" value="'+obj.tencongdoan+'" /></td>';
		row+='                      <td class="number"><input type="text" id="thututhuchien-'+ this.index +'" name="thututhuchien['+ this.index +']" class="text number" value="'+obj.thututhuchien+'" /></td>';
		row+='                      <td><input type="hidden" id="nguyenlieusanxuat-'+ this.index +'" name="nguyenlieusanxuat['+ this.index +']" value="'+obj.nguyenlieusanxuat+'"><input type="text" id="tennguyenlieusanxuat-'+ this.index +'" name="tennguyenlieusanxuat['+ this.index +']" class="text gridautocomplete" value="'+obj.tennguyenlieusanxuat+'" /></td>';
		row+='                      <td><input type="hidden" id="thietbisanxuatchinh-'+ this.index +'" name="thietbisanxuatchinh['+ this.index +']" value="'+obj.thietbisanxuatchinh+'"><input type="text" id="tenthietbisanxuatchinh-'+ this.index +'" name="tenthietbisanxuatchinh['+ this.index +']" class="text gridautocomplete" value="'+obj.tenthietbisanxuatchinh+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucchitieu-'+ this.index +'" name="dinhmucchitieu['+ this.index +']" class="text number" value="'+obj.dinhmucchitieu+'" /></td>';
		row+='                      <td class="number"><input type="text" id="giagiacong-'+ this.index +'" name="giagiacong['+ this.index +']" class="text number" value="'+obj.giagiacong+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucphelieu-'+ this.index +'" name="dinhmucphelieu['+ this.index +']" class="text number" value="'+obj.dinhmucphelieu+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucphepham-'+ this.index +'" name="dinhmucphepham['+ this.index +']" class="text number" value="'+obj.dinhmucphepham+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmuchaohut-'+ this.index +'" name="dinhmuchaohut['+ this.index +']" class="text number" value="'+obj.dinhmuchaohut+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucnangxuat-'+ this.index +'" name="dinhmucnangxuat['+ this.index +']" class="text number" value="'+obj.dinhmucnangxuat+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucphulieu-'+ this.index +'" name="dinhmucphulieu['+ this.index +']" class="text number" value="'+obj.dinhmucphulieu+'" /></td>';
		row+='                      <td class="number"><input type="text" id="soluongtrenkg-'+ this.index +'" name="soluongtrenkg['+ this.index +']" class="text number" value="'+obj.soluongtrenkg+'" /></td>';
		row+='                      <td><textarea class="text" id="ghichu-'+ this.index +'" name="ghichu['+ this.index +']">'+obj.ghichu+'</textarea></td>';
		row+='                      <td>'+id+btnXoa+btnXemQuaTrinh+'</td>';
		row+='                  </tr>';
		
		this.index++;
		return row
	}
	
	/*this.editCongDoan = function(id)
	{
		$.getJSON("?route=quanlykho/congdoan/getCongDoan&col=id&val="+id+"&operator=", 
				function(data) 
				{
					
					for( i in data.congdoans)
					{
						fillCongDoanForm(data.congdoans[i]);	
						numberReady();
					}
					
				});
		
	}
	
	this.fillCongDoanForm = function(obj)
	{
		$("#id").val(obj.id);
		$("#macongdoan").val(obj.macongdoan);
		$("#macongdoan").attr("readonly","readonly")
		$("#tencongdoan").val(obj.tencongdoan);
		$("#thututhuchien").val(obj.thututhuchien);
		$("#dinhmucchitieu").val(obj.dinhmucchitieu);
		$("#giagiacong").val(obj.giagiacong);
		$("#dinhmucphelieu").val(obj.dinhmucphelieu);
		$("#dinhmucphepham").val(obj.dinhmucphepham);
		$("#dinhmuchaohut").val(obj.dinhmuchaohut);
		$("#dinhmucnangxuat").val(obj.dinhmucnangxuat);
		$("#dinhmucphulieu").val(obj.dinhmucphulieu);
		$("#soluongtrenkg").val(obj.soluongtrenkg);
		$("#nguyenlieusanxuat").val(obj.nguyenlieusanxuat);
		$("#tennguyenlieu").html(obj.tennguyenlieusanxuat);
		$("#thietbisanxuatchinh").val(obj.thietbisanxuatchinh);
		$("#tentaisan").html(obj.tenthietbisanxuatchinh);
		$("#ghichu").val(obj.ghichu);
	}
	
	this.deleteCongDoan = function(id)
	{
		$.ajax({
			url: "?route=quanlykho/congdoan/delete&id="+id,
			cache: false,
			success: function(data)
			{
				if(data=="true")
				{
					$("#listcongdoan").html("");
					getCongDoan("malinhkien","<?php echo $item['id']?>","");
				}
			}
		});
	}*/
	this.delRow = function(pos)
	{
		$('#delcongdoans').val($('#delcongdoans').val()+ $('#id-'+pos).val()+",");
		$('#row-'+pos).remove();
	}
	
	this.viewCongDoan = function(macongdoan)
	{
		
		openDialog("?route=quanlykho/congdoan/viewCongDoan&macongdoan="+macongdoan,1000,800);
	}

}
var cd = new CongDoan()
$(document).ready(function() {
	cd.getCongDoan("malinhkien","<?php echo $item['id']?>","");
});



function callBackAutoComplete(val)
{
	//alert(val.id);
	ar = val.id.split("-");
	//alert(ar[0]);
	if(ar[0]=='tennguyenlieusanxuat')
	{
		getNguyenLieu("manguyenlieu",val.value,"like");
	}
	if(ar[0]=='tenthietbisanxuatchinh')
	{
		getTaiSan('mataisan',val.value,'like')
	}
}

function selectValue(eid)
{
	//alert(eid)
	ar = eid.split("-");
	if(ar[0]=='tennguyenlieusanxuat')
	{
		selectValueNguyenLieu(eid);
	}
	if(ar[0]=='tenthietbisanxuatchinh')
	{
		selectValueTaiSan(eid);
	}
}

function getNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				str = "";
				for( i in data.nguyenlieus)
				{
					str+= '<li id=rowauto-'+i+' class=autocompleterow>'+ data.nguyenlieus[i].manguyenlieu + ':' +data.nguyenlieus[i].tennguyenlieu+'</li><input type="hidden" id="idnguyenlieu-'+i+'" value="'+ data.nguyenlieus[i].id +'" />';
				}
				$("#autocomplete").html("<ul class='autocomplete'>"+str+"</ul>");
				auto.selectRow();
			});
}

function selectValueNguyenLieu(eid)
{
	str = auto.getValue();
	arr = str.split(":");
	
	$("#"+eid).val(arr[0]);
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=manguyenlieu&val="+arr[0]+"&operator=", 
			function(data) 
			{
				//alert(eid);
				ar = eid.split("-");
				pos = ar[1];
				for( i in data.nguyenlieus)
				{
					
					$("#nguyenlieusanxuat-"+pos).val(data.nguyenlieus[i].id);
					$("#tennguyenlieusanxuat-"+pos).val(data.nguyenlieus[i].tennguyenlieu);
					
				}
				
			});
	auto.closeAutocomplete()
}



function getTaiSan(col,val,operator)
{
	$.getJSON("?route=quanlykho/taisan/getTaiSan&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				
				str = "";
				for( i in data.taisans)
				{
					str+= '<li id=rowauto-'+i+' class=autocompleterow>'+ data.taisans[i].mataisan + ':' +data.taisans[i].tentaisan+'</li><input type="hidden" id="idtaisan-'+i+'" value="'+ data.taisans[i].id +'" />';
				}
				$("#autocomplete").html("<ul class='autocomplete'>"+str+"</ul>");
				auto.selectRow();
			});
}

function selectValueTaiSan(eid)
{
	str = auto.getValue();
	arr = str.split(":");
	
	$("#"+eid).val(arr[0]);
	$.getJSON("?route=quanlykho/taisan/getTaiSan&col=mataisan&val="+arr[0]+"&operator=", 
			function(data) 
			{
				//alert(eid);
				ar = eid.split("-");
				pos = ar[1];
				for( i in data.taisans)
				{
					
					$("#thietbisanxuatchinh-"+pos).val(data.taisans[i].id);
					$("#tenthietbisanxuatchinh-"+pos).val(data.taisans[i].tentaisan);
					
				}
				
			});
	auto.closeAutocomplete()
}
</script>
