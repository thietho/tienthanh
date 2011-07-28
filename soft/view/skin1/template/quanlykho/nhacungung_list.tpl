<div class="section">

	<div class="section-title">Quản lý danh mục nhà cung ứng</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manhacungung" name="manhacungung" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tennhacungung" name="tennhacungung" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomnhacungung as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                <label>Địa chỉ</label>
                <input type="text" id="diachi" name="diachi" class="text" value="" /><br />
                <label>Khu vực</label>
                <select id="khuvuc" name="khuvuc">
                    <option value=""></option>
                    <?php foreach($khuvuc as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <label>Điện thoại</label>
                <input type="text" id="dienthoai" name="dienthoai" class="text" value="" />
                <label>Fax</label>
                <input type="text" id="fax" name="fax" class="text" value="" />
                <label>Người đứng đầu</label>
                <input type="text" id="tennguoidungdau" name="tennguoidungdau" class="text" value="" />
               	
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '<?php echo $list?>'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectNhaCungUng()">
                <input type="hidden" id="selectnhacungcung" name="selectnhacungcung" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        <th>STT</th>
                        <th>Mã nhà cung ứng</th>
                        <th>Tên nhà cung ứng</th>
                        <th>Địa chỉ</th>
                        <th>Điện thoại</th>
                        <th>Fax</th>
                        <th>Người đứng đầu</th>
                        <th>Hiệu lực đến ngày</th>
                        <th>Ngày đánh giá lại</th>
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
                        <td><?php echo $item['manhacungung']?></td>
                        <td><?php echo $item['tennhacungung']?></td>
                        <td><?php echo $item['diachi']?></td>
                        <td><?php echo $item['dienthoai']?></td>
                        <td><?php echo $item['fax']?></td>
                        <td><?php echo $item['tennguoidungdau']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['hieulucdenngay'])?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaydanhgialai'])?></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                           	<input type="button" class="button" name="btnLichsugiaodich" value="<?php echo $item['text_lichsugiaodich']?>" onclick="window.location='<?php echo $item['link_lichsugiaodich']?>'"/>
                            <input type="button" class="button" name="btnLichsudanhgia" value="<?php echo $item['text_lichsudanhgia']?>" onclick="window.location='<?php echo $item['link_lichsudanhgia']?>'"/>
                            
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
		$.post("?route=quanlykho/nhacungung/delete", 
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
	var url =  "<?php echo $list?>";
	<?php if($dialog==true){ ?>
		url += "&opendialog=true";
	<?php } ?>
	if($("#manhacungung").val() != "")
		url += "&manhacungung=" + $("#manhacungung").val();
	
	if($("#tennhacungung").val() != "")
		url += "&tennhacungung="+ $("#tennhacungung").val();
	if($("#manhom").val() != "")
		url += "&manhom="+ $("#manhom").val();
	if($("#diachi").val() != "")
		url += "&diachi=" + $("#diachi").val();
	if($("#khuvuc").val() != "")
		url += "&khuvuc=" + $("#khuvuc").val();
	if($("#dienthoai").val() != "")
		url += "&dienthoai="+ $("#dienthoai").val();
	if($("#fax").val() != "")
		url += "&fax=" + $("#fax").val();
	if($("#tennguoidungdau").val() != "")
		url += "&tennguoidungdau=" + $("#tennguoidungdau").val();
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

function selectNhaCungUng()
{
	window.opener.document.getElementById('manhacungung').value = $("#selectnhacungcung").val();
	window.close();
}

$("#manhacungung").val("<?php echo $_GET['manhacungung']?>");
$("#tennhacungung").val("<?php echo $_GET['tennhacungung']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");
$("#diachi").val("<?php echo $_GET['diachi']?>");
$("#khuvuc").val("<?php echo $_GET['khuvuc']?>");
$("#dienthoai").val("<?php echo $_GET['dienthoai']?>");
$("#fax").val("<?php echo $_GET['fax']?>");
$("#tennguoidungdau").val("<?php echo $_GET['tennguoidungdau']?>");

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnhacungcung").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnhacungcung").val($("#selectnhacungcung").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>
</script>