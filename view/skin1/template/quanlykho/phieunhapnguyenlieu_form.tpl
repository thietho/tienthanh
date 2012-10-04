<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>

<div class="section" id="sitemaplist">

	<div class="section-title">Phiếu nhập nguyên vật liệu</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieunhapnguyenlieu')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                	<li class="tabs-selected"><a href="#fragment-phieunhapnguyenlieu"><span>Thông tin phiếu nhập nguyên vật liệu</span></a></li>
                    <li class="tabs"><a href="#fragment-chitietphieunhapnguyenlieu"><span>Chi tiết phiếu nhập nguyên vật liệu</span></a></li>
                </ul>
    
                <div id="fragment-phieunhapnguyenlieu" class="tabs-container">   
                    <?php if($item['maphieu']!=""){ ?>
                    <p>
                        <label>Số chứng từ</label><br />
                        <input type="hidden" name="maphieu" value="<?php echo $item['maphieu']?>" class="text" size=60  />
                        <?php echo $item['maphieu']?>
                    </p>
                    <?php } ?>
                    <p>
                        <label>Người giao</label><br/>
                        <input id="nguoigiao" type="text" name="nguoigiao" value="<?php echo $item['nguoigiao'] ?>" class="text" size="60" />
                    </p>   
                    
                    <p>
                        <label>Loại nhập</label><br/>
                        <select id="loainguon" name="loainguon">
                        	<option value=""></option>
                            <?php foreach($this->document->loainguon as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <input type="hidden" name="loaiphieu" value="nhap-nguyenlieu" />
                    <p>
                        <label>Số chứng từ đầu ra</label><br/>
                        <!--<input type="hidden" id="selectmaphieunhanhang" name="selectmaphieunhanhang"/>
                        <input type="hidden" id="selectmaphieuxuatnhap" name="selectmaphieuxuatnhap" />-->
                        <input id="maphieunguon" type="text" name="maphieunguon" value="<?php echo $item['maphieunguon'] ?>" class="text" size="60" />
                        <!--<input type="button" class="button chonnguon hidden" id="btn_nh" name="btnPhieuNhanHang" value="Chọn phiếu nhận hàng" onclick="selectPhieuNhanHang()"/>
                        <input type="button" class="button chonnguon hidden" id="btn_nt" name="btnPhieuNhanHang" value="Chọn phiếu xuất thẳng" onclick="selectPhieuXuatThang()"/>
                        <input type="button" class="button chonnguon hidden" id="btn_ncd" name="btnPhieuNhanHang" value="Chọn phiếu xuất cho công đoạn" onclick="selectPhieuXuatChoCongDoan()"/>-->
                    </p>   
                    
                    <p id="rowkho">
                    	<label>Nhập vào kho</label><br/>
                        <input id="makho" type="hidden" name="makho" value="<?php echo $item['makho'] ?>" class="text" size="60" />
                        <input id="tenkho" type="text" name="tenkho" value="<?php echo $item['tenkho'] ?>" class="text" size="60" readonly />
                        <input type="button" class="button" name="btnChonKho" value="Chọn kho" onClick="selectKho()">
                    	<input type="button" class="button" name="btnChonKho" value="Bỏ chọn" onClick="unSelectKho()"> 
                    </p>
                    
                    <!--<p>
                        <label>Ngày nhập</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngaynhap").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                         <input type="text" id="ngaynhap" name="ngaynhap" value="<?php echo $this->date->formatMySQLDate($item['ngaynhap'])?>" class="text" size=60 />
                    </p>-->
                    
                    <p>
                        <label>Mã hợp đồng</label><br />
                        <input type="text" name="mahopdong" value="<?php echo $item['mahopdong']?>" class="text" size=60 />
                    </p>
                    
                     <p>
                        <label>Ngày lập phiếu</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngaylapphieu").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                         <input type="text" id="ngaylapphieu" name="ngaylapphieu" value="<?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?>" class="text" size=60 />
                    </p>
                    
                    
                    <p>
                        <label>Nhân viên lập phiếu</label><br/>
                        <input type="hidden" name="nguoilap" value="<?php echo $item['nguoilap'] ?>" class="text" size=60 />
                        <input type="text" name="tennguoilap" value="<?php echo $item['tennguoilap'] ?>" readonly class="text" size=60 />
                    </p>
                    
                    <!--<p>
                        <label>Tình trạng phiếu</label><br/>
                        <select id="tinhtrang" name="tinhtrang">
                            <?php foreach($this->document->thanhtoan as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>-->
                    <input type="hidden" name="tinhtrang" value="chuathanhtoan" />
                  	<p>
                    	<label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu'] ?></textarea>
                    </p>
                </div>
                
                <!-- chi tiet phieu nhap nguyen lieu -->
                <div id="fragment-chitietphieunhapnguyenlieu" class="tabs-container">
                	
                    <p>
                        <label>Chi tiết phiếu nhập nguyên vật liệu</label>
                        <p>
                            <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                            <table style="width:auto">
                                <thead>
                                    <tr>
                                        <th>Mã nguyên vật liệu</th>
                                        <th>Tên nguyên vật liệu</th>
                                        <th>Số lượng</th>
                                        <th>Thực nhập</th>
                                        <th>Bao bì</th>
                                        <th>Đơn vị tính</th>
                                        <th>Đơn giá</th>
                                        <th>Ghi chú</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody id="chitiet">
                                    
                                </tbody>
                            </table>
                            <input type="hidden" id="delchitiet" name="delchitiet" />
                            <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="newRow()">
                        </p>
                    </p>
                
                </div>
                <!-- end chi tiet phieu nhan hang -->
                
            </div>
        </form>
    
    </div>
    
</div>

<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>
<script language="javascript">
var auto = new AutoComplete();
var index = 0;
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieunhapnguyenlieu/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/phieunhapnguyenlieu";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});

$("#tinhtrang").val("<?php echo $item['tinhtrang']?>");
$("#loainguon").val("<?php echo $item['loainguon']?>");
//bat dau javascript cho chi tiet

<?php 
	$index = 0;
	
	if(count($chitiet))
	{
		foreach($chitiet as $val)
		{ 
	?>
			createRow(	"<?php echo $val['id']?>",
						"<?php echo $val['itemid']?>",
						"<?php echo $this->document->getNguyenLieu($val['itemid'],'manguyenlieu')?>",
						"<?php echo $val['itemname']?>",
						"<?php echo $val['soluong']?>",
						"<?php echo $val['dongia']?>",
						"<?php echo $val['madonvi']?>",
						"<?php echo $val['thucnhap']?>",
						"<?php echo $val['baobi']?>",
						"<?php echo $val['ghichu']?>"
					);
	<?php
			$index += 1;
		} 
	}
?>

function selectNguyenLieu()
{
	$('#manguyenlieu').val('');
	
	openDialog("?route=quanlykho/nguyenlieu&opendialog=true",1000,800);
	
	list = trim($("#manguyenlieu").val(), ',');
	arr = list.split(",");
	
	for(i in arr)
	{
		createRow("",arr[i],"", 0, 0, "", 0,"");
	}
	
}


function newRow()
{
	createRow("","","","", 0, 0, "", 0,0, "");
}
function createRow(id, manguyenlieu,manguyenlieutext, tennguyenlieu,  soluong, dongia, madonvi,  thucnhap,baobi, ghichu)
{
	
	var cellid = '<input type="hidden" name="chitiet['+index+']" value="' +id+ '">';
	var cellitemid = '<input type="hidden" id="itemid-'+ index +'" name="itemid['+index+']" value="' + manguyenlieu + '">';
	
	cellmanguyenlieu = '<input type="text" class="text gridautocomplete" size=10 id="manguyenlieutext-'+ index +'" name="manguyenlieutext['+index+']" value="' + manguyenlieutext + '">';
	
	var celltennguyenlieu = '<input type="text" id="tennguyenlieu-'+index+'" name="tennguyenlieu['+index+']" size=10 value="' + tennguyenlieu + '" readonly>';
	
	var cellsoluong = '<input type="text" name="soluong['+index+']" value="'+soluong+'" class="text number" size=5 />';
	var celldongia = '<input type="text" name="dongia['+index+']" value="'+dongia+'" class="text number" size=5 />';
	var cellmadonvi = "<select id='madonvi-" + index + "' name='madonvi[" + index + "]'>" 
						+ "<?php foreach($donvitinh as $val){ ?>"
						+ "<option value='<?php echo $val['madonvi']; ?>'><?php echo $val['tendonvitinh'] ?></option><?php } ?>"
						+ "</select>";		
	
	
	var cellthucnhap = '<input type="text" name="thucnhap['+index+']" value="'+thucnhap+'" class="text number" size=5 />';
	var cellbaobi = '<input type="text" name="baobi['+index+']" value="'+baobi+'" class="text number" size=5 />';
	var cellghichu ='<textarea id="ghichuchitiet-'+index+'" name="ghichuchitiet[' + index + ']" class="ben-grid">'+ghichu+'</textarea>';
	var row ="";
	row+='						<tr id="row'+index+'">';
	row+='                          <td>'+cellid+cellitemid+cellmanguyenlieu+'</td>';
	row+='                          <td>'+celltennguyenlieu+'</td>';
	
	row+='                          <td>'+cellsoluong+'</td>';
	row+='                          <td>'+cellthucnhap+'</td>';
	row+='                          <td>'+cellbaobi+'</td>';
	row+='                          <td>'+cellmadonvi+'</td>';
	row+='                          <td>'+celldongia+'</td>';
	
	row+='                          <td>'+cellghichu+'</td>';
	row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+',\''+id+'\')"></td>';
	
	row+='                      </tr>';
	
	$("#chitiet").append(row);
	if(madonvi == "")
		$("#madonvi-"+index+"").val(madonvi);
	else
		$("#madonvi-"+index+"").val(madonvi);
	if(dongia == 0)
		$("#dongia-"+index+"").val(dongia);
	
	index++;
	numberReady();
	auto.autocomplete();
}

function removeRow(pos,id)
{
	$("#delchitiet").val($("#delchitiet").val()+","+id);
	$("#row"+pos).remove();
}
//end javascript cho chi tiet


//chon kho
function getKho(col,val,operator)
{
	$.getJSON("?route=quanlykho/kho/getKho&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.khos)
				{
					$("#makho").val(data.khos[i].makho);
					$("#tenkho").val(data.khos[i].tenkho);
				}
			});
}

function selectKho()
{
	openDialog("?route=quanlykho/kho&opendialog=true",1000,800);
	
	list = trim($("#makho").val(), ',');
	arr = list.split(",");
	makho = arr[0];
	getKho("makho",makho,'');
}

function unSelectKho()
{
	if($("#tenkho").val().length > 0)
	{
		$("#makho").val("");
		$("#tenkho").val("");
	}
}
//end chon kho
//chon nguon
$("#loainguon").change(function() {
	$(".chonnguon").hide();
	$("#btn_"+$(this).val()).show();
});
//Chon phieu nhan hang
function selectPhieuNhanHang()
{
	openDialog("?route=quanlykho/phieunhanhang&trangthai=pending&opendialog=true",1000,800);
	list = trim($("#selectmaphieunhanhang").val(), ',');
	arr = list.split(",");
	id = arr[0];
	//alert(id)
	getPhieuNhanHang("id",id,'');
}

function getPhieuNhanHang(col,val,operator)
{
	$.getJSON("?route=quanlykho/phieunhanhang/getPhieuNhanHang&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.phieunhanhangs)
				{
					$("#maphieunguon").val(data.phieunhanhangs[i].maphieunhanhang);
					//getChiTietPhieuNhanHang(data.phieunhanhangs[i].id);
					
				}
			});
}

function getChiTietPhieuNhanHang(maphieunhanhang)
{
	$.getJSON("?route=quanlykho/phieunhanhang/getChiTietPhieuNhanHang&maphieunhanhang="+maphieunhanhang, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.chitietphieunhanhangs)
				{
					id = 0;
					manguyenlieu = data.chitietphieunhanhangs[i].manguyenlieu;
					
					soluong = data.chitietphieunhanhangs[i].soluong;
					dongia = data.chitietphieunhanhangs[i].dongia;
					madonvi = "";
					
					thucnhap = data.chitietphieunhanhangs[i].soluongnhan;
					createRow(id, manguyenlieu, soluong, dongia, madonvi, thucnhap);
				}
			});
}

//Chon phieu xuat nguyen lieu
function selectPhieuXuatNguyenLieu(loai)
{
	openDialog("?route=quanlykho/phieuxuatnguyenlieu&loaiphieu="+loai+"&trangthai=completed&opendialog=true",1000,800);
	list = trim($("#selectmaphieuxuatnhap").val(), ',');
	arr = list.split(",");
	id = arr[0];
	//alert(id)
	getPhieuXuatNguyenLieu("id",id,'');
}

function getPhieuXuatNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/phieuxuatnguyenlieu/getPhieuXuatNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.phieuxuatnguyenlieus)
				{
					$("#maphieunguon").val(data.phieuxuatnguyenlieus[i].maphieu);
					getChiTietPhieuNhapXuat(data.phieuxuatnguyenlieus[i].id);
				}
			});
}

function selectPhieuXuatThang()
{
	selectPhieuXuatNguyenLieu("xt");
}

function selectPhieuXuatChoCongDoan()
{
	selectPhieuXuatNguyenLieu("xtg");
}

function getChiTietPhieuNhapXuat(maphieu)
{
	$.getJSON("?route=quanlykho/phieunhapxuat/getChiTiet&maphieu="+maphieu, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.chitietphieunhapxuats)
				{
					id = 0;
					manguyenlieu = data.chitietphieunhapxuats[i].itemid;
					
					soluong = data.chitietphieunhapxuats[i].soluong;
					dongia = data.chitietphieunhapxuats[i].dongia;
					madonvi = "";
					
					thucnhap = data.chitietphieunhapxuats[i].thucxuat;
					createRow(id, manguyenlieu, soluong, dongia, madonvi, thucnhap);
				}
			});
}

function callBackAutoComplete(val)
{
	getNguyenLieu("manguyenlieu",val.value,"like");
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

function selectValue(eid)
{
	str = auto.getValue();
	arr = str.split(":");
	
	$("#"+eid).val(arr[0]);
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=manguyenlieu&val="+arr[0]+"&operator=", 
			function(data) 
			{
				
				ar = eid.split("-");
				pos = ar[1];
				for( i in data.nguyenlieus)
				{
					$("#manguyenlieutext-"+pos).val(data.nguyenlieus[i].manguyenlieu);
					$("#tennguyenlieu-"+pos).val(data.nguyenlieus[i].tennguyenlieu);
					$("#itemid-"+pos).val(data.nguyenlieus[i].id);
					$("#madonvi-"+pos).val(data.nguyenlieus[i].madonvi);
				}
				
			});
	auto.closeAutocomplete()
}
</script>
