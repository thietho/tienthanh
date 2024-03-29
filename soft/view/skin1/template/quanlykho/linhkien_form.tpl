<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm_linhkien_form" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                	<li class="tabs-selected"><a href="#fragment-thongtinnguyenlieu"><span>Thông tin linh kiện</span></a></li>
                    <li class="tabs"><a href="#fragment-sanphamsudung"><span>Sản phẩm sử dụng</span></a></li>
                </ul>
    
                <div id="fragment-thongtinnguyenlieu" class="tabs-container">
                    <p>
                        <label>Mã linh kiện</label><br />
                        <input type="text" id="malinhkien" name="malinhkien" value="<?php echo $item['malinhkien']?>" class="text" size=60 />
                        
                    </p>
                    
                    
                    <p>
                        <label>Tên linh kiện</label><br />
                        <input type="text" id="tenlinhkien" name="tenlinhkien" value="<?php echo $item['tenlinhkien']?>" class="text" size=60 />
                        
                    </p>
                   
                    <p>
                        <label>Kho</label><br />
                        <select id="makho" name="makho">
                            <option value=""></option>
                            <?php foreach($kho as $val){ ?>
                            <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Linh kiện /Lot</label><br />
                        <input type="text" id="solinhkientrenlot" name="solinhkientrenlot" value="<?php echo $item['solinhkientrenlot']?>" class="text number" size=60 />
                    </p>
                    <p>
                        <label>Số lượng con / Kg</label><br />
                        <input type="text" id="soluongcontrenkg" name="soluongcontrenkg" value="<?php echo $item['soluongcontrenkg']?>" class="text number" size=60 />
                    </p>
                    
                    <p>
                        <label>Tiền công</label><br />
                        <input type="text" id="tiencong" name="tiencong" value="<?php echo $item['tiencong']?>" class="text number" size=60 />
                        <?php if($item['id']){ ?>
                        <input type="button" class="button" name="btnTinhTienCong" value="Tính tiền công" onclick="tinhtiencong('<?php echo $item['id']?>')"/>
                        <?php } ?>
                    </p>
                    <p>
                        <label>Định mức</label><br />
                        <input type="text" id="dinhmuc" name="dinhmuc" value="<?php echo $item['dinhmuc']?>" class="text number" size=60 />
                    </p>
                    <p>
                        <label>Tồn tối thiểu</label><br />
                        <input type="text" id="tontoithieu" name="tontoithieu" value="<?php echo $item['tontoithieu']?>" class="text number" size=60 />
                    </p>
                    <p>
                        <label>Tồn tối đa</label><br />
                        <input type="text" id="tontoida" name="tontoida" value="<?php echo $item['tontoida']?>" class="text number" size=60 />
                    </p>
                    <p>
                        <label>Đơn vị tính</label><br />
                        <select id="madonvi" name="madonvi">
                            <option value=""></option>
                            <?php foreach($donvitinh as $val){ ?>
                            <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
                    </p>
                    <p>
                        <label>Nguyên liệu sử dụng</label><br />
                        <input type="hidden" id="manguyenlieu" name="manguyenlieu" value="">
                        <input type="hidden" id="nguyenlieusudung" name="nguyenlieusudung" value="">
                        <span id="tennguyenlieu"></span>
                        <input type="button" class="button" name="btnChonNguyenLieu" value="Chọn nguyên vật liệu" onClick="selcetNguyenLieu()">
                        <input type="button" class="button" name="btnBoChonNguyenLieu" value="Bỏ chọn" onClick="unSelcetNguyenLieu()">
                    </p>
                    <p>
                        <label>Số lượng sử dụng cho 1 linh kiện</label>
                        <input type="text" id="soluongnguyenlieu" name="soluongnguyenlieu" value="<?php echo $item['soluongnguyenlieu']?>" class="text number" size=20 />
                        <select id="madonvinguyenlieu" name="madonvinguyenlieu">
                            <option value=""></option>
                            <?php foreach($donvitinh as $val){ ?>
                            <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                            <?php } ?>
                        </select>
                    </p>
					<p id="pnImage">
                        <label for="image">Hình</label><br />
                    
                        <input type="button" class="button" value="Chọn hình" onclick="browserFile('imageid','single')"/><br />
                        <img id="imageid_preview" src="<?php echo $item['imagethumbnail']?>" onclick="showFile($('#imageid_fileid').val())"/>
                        <input type="hidden" id="imageid_filepath" name="imagepath" value="<?php echo $item['imagepath']?>" />
                        <input type="hidden" id="imageid_fileid" name="imageid" value="<?php echo $item['imageid']?>" />
                    </p>
                    
                    
                    <div id="errorupload" class="error" style="display:none"></div>
                    
                    <div class="loadingimage" style="display:none"></div>
                </div>
                <div id="fragment-sanphamsudung" class="tabs-container">
                	
                	
                    <p>
                    	<input type="hidden" id="selectsanpham" name="selectsanpham">
                        <table style="width:auto">
                        	<thead>
                                <tr>
                                	<th>Mã sản phẩm</th>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng sử dụng</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="dinhluongsanpham">
                            	
                            </tbody>
                        </table>
                        <input type="hidden" id="deldinhluong" name="deldinhluong" />
                        <input class="button" type="button" id="btnAddrow" name="btnAddrow" value="Thêm dòng">
                    </p>
                
                </div>
			</div>
        	
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
<?php 
if(count($dinhluong))
	foreach($dinhluong as $val){ ?>
		var obj = new Object()
		
		createRow('<?php echo $val[id]?>',"<?php echo $val['masanpham']?>","<?php echo $this->document->getSanPham($val['masanpham'])?>","<?php echo $val['soluong']?>");
		
<?php } ?>
});

function tinhtiencong(id)
{
	$.ajax({
		url: "?route=quanlykho/linhkien/tinhTienCong&id="+id,
		cache: false,
		success: function(html){
			$("#tiencong").val(html);
			numberReady();
		}
	});
}

$("#frm_linhkien_form #manhom").val("<?php echo $item['manhom']?>");

$("#frm_linhkien_form #makho").val("<?php echo $item['makho']?>");
$("#frm_linhkien_form #madonvi").val("<?php echo $item['madonvi']?>");
$("#frm_linhkien_form #madonvinguyenlieu").val("<?php echo $item['madonvinguyenlieu']?>");
getNguyenLieu("id","<?php echo $item['nguyenlieusudung']?>",'');

function getNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.nguyenlieus)
				{
					
					$("#nguyenlieusudung").val(data.nguyenlieus[i].id);
					
					$("#tennguyenlieu").html(data.nguyenlieus[i].tennguyenlieu);
				}
				
			});
}

function selcetNguyenLieu()
{	
	$("#popup").attr('title','Chọn nguyên liệu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: window.innerHeight,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");
			
		});
}
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
		$("#nguyenlieusudung").val(this.id);			
		$("#tennguyenlieu").html($(this).attr('tennguyenlieu'));
		$("#popup").dialog( "close" );
	});	
}
function unSelcetNguyenLieu()
{
	$("#manguyenlieu").val("");
	$("#nguyenlieusudung").val("");
	$("#tennguyenlieu").html("");
}

//Su ly chi tiet
$('#btnAddrow').click(function(e) {
    selcetSanPham();
});
function selcetSanPham()
{
	/*openDialog("?route=quanlykho/sanpham&opendialog=true",800,500);
	
	list = trim($("#selectsanpham").val(), ',');
	arr = list.split(",");
	malinhkien = arr[0];
//	getLinhKien("id",malinhkien,'');
	for(i in arr)
	{
		
		createRow(0,arr[i],0);
	}*/
	$("#popup").attr('title','Chọn sản phẩm');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: window.innerHeight,
			modal: true,
			buttons: {
				
				
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						
						createRow(0,this.id,$(this).attr('tensanpham'),1)
						
                    });
					$('#popup-seletetion').html("");
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/sanpham&opendialog=true",function(){
			$("#popup").dialog("open");
		});
}
function intSelectSanPham()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' masanpham='"+$(this).attr('masanpham')+"' tensanpham='"+$(this).attr('tensanpham')+"'>"+$(this).attr('masanpham')+":"+ $(this).attr('tensanpham') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
	});	
}
var index = 0;
function createRow(id,masanphamm,tensanpham,soluong)
{
	
			
		var cellid = '<input type="hidden" name="dinhluong['+index+']" value="' +id+ '">';
		var cellmasanpham = '<input type="hidden" name="masanpham['+index+']" value="' +masanphamm+ '">';
		var cellsoluong = '<input type="text" name="soluong['+index+']" value="'+soluong+'" class="text number" size=5 />';
		var row ='';
		row+='						<tr id="row'+index+'">';
		row+='                      	<td>'+cellid + tensanpham+'</td>';
		row+='                          <td>'+cellmasanpham+cellsoluong+'</td>';
		row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+','+id+')"></td>';
		row+='                      </tr>';
	
	$("#dinhluongsanpham").append(row);
	index++;
	numberReady();
	
}

function removeRow(pos,dlid)
{
	$("#deldinhluong").val($("#deldinhluong").val()+","+dlid);
	$("#row"+pos).remove();
}

var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";

</script>
