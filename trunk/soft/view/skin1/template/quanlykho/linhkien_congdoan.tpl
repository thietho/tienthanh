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
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/linhkien/savecongdoan", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/linhkien/caidatcongdoan&id=<?php echo $item['id']?>";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
//Nguyen Lieu
function getNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.nguyenlieus)
				{
					
					$("#nguyenlieusanxuat").val(data.nguyenlieus[i].id);
					$("#tennguyenlieu").html(data.nguyenlieus[i].tennguyenlieu);
				}
				
			});
}

function selcetNguyenLieu()
{
	openDialog("?route=quanlykho/nguyenlieu&opendialog=true",1000,800);
	
	list = trim($("#manguyenlieu").val(), ',');
	arr = list.split(",");
	manguyenlieu = arr[0];
	getNguyenLieu("id",manguyenlieu,'');
}

function unSelcetNguyenLieu()
{
	$("#manguyenlieu").val("");
	$("#nguyenlieusanxuat").val("");
	$("#tennguyenlieu").html("");
}
//Tai san
function getTaiSan(col,val,operator)
{
	$.getJSON("?route=quanlykho/taisan/getTaiSan&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.taisans)
				{
					
					$("#thietbisanxuatchinh").val(data.taisans[i].id);
					$("#tentaisan").html(data.taisans[i].tentaisan);
				}
				
			});
}

function selcetTaiSan()
{
	openDialog("?route=quanlykho/taisan&opendialog=true",1000,800);
	list = trim($("#selecttaisan").val(), ',');
	arr = list.split(",");
	mataisan = arr[0];
	getTaiSan("id",mataisan,'');
}

function unSelcetTaiSan()
{
	$("#manguyenlieu").val("");
	$("#nguyenlieusanxuat").val("");
	$("#tennguyenlieu").html("");
}
//Cong doan
function CongDoan()
{
	this.index = 0;
	
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
					numberReady();
				});
	}
	
	this.createRowCongDoan = function(obj)
	{
		var btnSua = '<input type="button" value="Sửa" class="button" onClick="editCongDoan('+obj.id+')"/>';
		var btnXoa = '<input type="button" value="Xóa" class="button" onClick="deleteCongDoan('+obj.id+')"/>';
		var btnXemQuaTrinh = '<input type="button" value="Xem quá trình biến đổi" class="button" onClick="viewCongDoan(\''+obj.macongdoan+'\')"/>';
		var row = '';
		row+='					<tr>';
		row+='                    	<td><input type="text" id="macongdoan['+ this.index +']" name="macongdoan['+ this.index +']" class="text" value="'+obj.macongdoan+'" /></td>';
		row+='                      <td><input type="text" id="tencongdoan['+ this.index +']" name="tencongdoan['+ this.index +']" class="text" value="'+obj.tencongdoan+'" /></td>';
		row+='                      <td class="number"><input type="text" id="thututhuchien['+ this.index +']" name="thututhuchien['+ this.index +']" class="text number" value="'+obj.thututhuchien+'" /></td>';
		row+='                      <td>'+obj.tennguyenlieusanxuat+'</td>';
		row+='                      <td>'+obj.tenthietbisanxuatchinh+'</td>';
		row+='                      <td class="number"><input type="text" id="dinhmucchitieu['+ this.index +']" name="dinhmucchitieu['+ this.index +']" class="text number" value="'+obj.dinhmucchitieu+'" /></td>';
		row+='                      <td class="number"><input type="text" id="giagiacong['+ this.index +']" name="giagiacong['+ this.index +']" class="text number" value="'+obj.giagiacong+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucphelieu['+ this.index +']" name="dinhmucphelieu['+ this.index +']" class="text number" value="'+obj.dinhmucphelieu+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucphepham['+ this.index +']" name="dinhmucphepham['+ this.index +']" class="text number" value="'+obj.dinhmucphepham+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmuchaohut['+ this.index +']" name="dinhmuchaohut['+ this.index +']" class="text number" value="'+obj.dinhmuchaohut+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucnangxuat['+ this.index +']" name="dinhmucnangxuat['+ this.index +']" class="text number" value="'+obj.dinhmucnangxuat+'" /></td>';
		row+='                      <td class="number"><input type="text" id="dinhmucphulieu['+ this.index +']" name="dinhmucphulieu['+ this.index +']" class="text number" value="'+obj.dinhmucphulieu+'" /></td>';
		row+='                      <td class="number"><input type="text" id="soluongtrenkg['+ this.index +']" name="soluongtrenkg['+ this.index +']" class="text number" value="'+obj.soluongtrenkg+'" /></td>';
		row+='                      <td><textarea id="ghichu['+ this.index +']" name="ghichu['+ this.index +']">'+obj.ghichu+'</textarea></td>';
		row+='                      <td>'+btnSua+btnXoa+btnXemQuaTrinh+'</td>';
		row+='                  </tr>';
		return row
	}
	
	this.editCongDoan = function(id)
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
</script>
