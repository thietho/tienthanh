<div class="section">

	<div class="section-title">Quản lý danh mục sản phẩm</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="masanpham" name="masanpham" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tensanpham" name="tensanpham" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomsanpham as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loaisanpham as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <label>Kho</label>
                <select id="makho" name="makho">
                    <option value=""></option>
                    <?php foreach($kho as $val){ ?>
                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                    <?php } ?>
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/sanpham'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectSanPham()">
                <input type="hidden" id="selectsanpham" name="selectsanpham" />
                <?php }else{ ?>
                <input class="button" value="Add new" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()"/>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        	<?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                        </th>
                        <th>STT</th>
                        <th>Mã sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Nhóm</th>
                        <th>Loại</th>
                        <th>Kho</th>
                        <th>Đơn vị tính</th>
                        <th>Đơn giá bán</th>
                        <th>Số lượng tồn</th>
                        <th>Đóng gói</th>
                        <th>Khu vực</th>
                        <th>Phân cấp</th>
                        <th>Hiện hành</th>
                        <th>Ghi chú</th>
                        <th>hình</th>
                        <?php if($dialog!=true){ ?>
                        <th>Control</th>     
                        <?php } ?>
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['masanpham']?></td>
                        <td><?php echo $item['tensanpham']?></td>
                        <td><?php echo $item['tennhom']?></td>
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        <td><?php echo $item['madonvi']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongiaban'])?></td>
                		<td class="number"><?php echo $this->string->numberFormate($item['soluongton'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['donggoi'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['khuvuc'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['phancap'])?></td>
                        <td><?php echo $this->document->hienhanh[$item['hienhanh']]?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>
                            <input type="button" class="button" name="btnCongDoan" value="<?php echo $item['text_congdoan']?>" onclick="window.location='<?php echo $item['link_congdoan']?>'"/>
                            <input type="button" class="button" name="btnLichSu" value="<?php echo $item['text_lichsu']?>" onclick="viewSanPham('<?php echo $item['masanpham']?>')"/>
                            <input type="button" class="button" name="btnCaiDatChiPhi" value="<?php echo $item['text_caidatchiphi']?>" onclick="window.location='<?php echo $item['link_caidatchiphi']?>'"/>
                            <input type="button" class="button" name="btnTinhTienCongTonghop" value="<?php echo $item['text_tinhtiencongtonghop']?>" onclick="window.location='<?php echo $item['link_tinhtiencongtonghop']?>'"/>
                           	
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/sanpham/delete", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}

function searchForm()
{
	var url =  "?route=quanlykho/sanpham";
	if($("#masanpham").val() != "")
		url += "&masanpham=" + $("#masanpham").val();
	
	if($("#tensanpham").val() != "")
		url += "&tensanpham="+ $("#tensanpham").val();
	if($("#manhom").val() != "")
		url += "&manhom=" + $("#manhom").val();
	if($("#loai").val() != "")
		url += "&loai="+ $("#loai").val();
	if($("#makho").val() != "")
		url += "&makho=" + $("#makho").val();
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

$("#masanpham").val("<?php echo $_GET['masanpham']?>");
$("#tensanpham").val("<?php echo $_GET['tensanpham']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");
$("#loai").val("<?php echo $_GET['loai']?>");
$("#makho").val("<?php echo $_GET['makho']?>");

function selectSanPham()
{
	window.opener.document.getElementById('selectsanpham').value = $("#selectsanpham").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectsanpham").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectsanpham").val($("#selectsanpham").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>

function viewSanPham(masanpham)
{
	
	openDialog("?route=quanlykho/sanpham/lichsu&masanpham="+masanpham,1000,800);
}
</script>