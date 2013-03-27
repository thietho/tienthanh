<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="makhachhang" name="makhachhang" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="hoten" name="hoten" class="text" value="" />
                <label>Khu vực</label>
                <select id="khuvuc" name="khuvuc">
                    <option value=""></option>
                    <?php foreach($khuvuc as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <label>Loại khách hàng</label>
                <select id="loaikhachhang" name="loaikhachhang">
                    <option value=""></option>
                    <?php foreach($loaikhachhang as $key => $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/khachhang'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectKhachHang()">
                <input type="hidden" id="selectkhachhang" name="selectkhachhang" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("quanlykho/khachhang/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/khachhang/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>  
            </div>
            
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        <?php if($dialog==false){ ?>
                        <input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                        <?php } ?>
                        </th>
                        
                        <th>STT</th>
                        <th>Mã khách hàng</th>
                        <th>Họ tên</th>
                        <th>Địa chỉ</th>
                        <th>Khu vực</th>
                        
                        <th>Điện thoại</th>
                        <th>Fax</th>
                        <th>Người đại diện</th>
                        <th>Loại khách hàng</th>
                        <th>Control</th>                                  
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
                        <td><?php echo $item['makhachhang']?></td>
                        <td><?php echo $item['hoten']?></td>
                        <td><?php echo $item['diachi']?></td>
                        <td><?php echo $this->document->getTenNhom($item['khuvuc'])?></td>
                        <td><?php echo $item['dienthoai']?></td>
                        <td><?php echo $item['fax']?></td>
                        <td><?php echo $item['nguoidaidien'] ?></td>
                        <td><?php echo $this->document->getTenNhom($item['loaikhachhang']) ?></td>
                        <td class="link-control">
                        	<?php if($this->user->checkPermission("quanlykho/khachhang/update")==true){ ?>
                        	<input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                        </td>
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
		$.post("?route=quanlykho/khachhang/delete", 
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
	var url =  "?route=quanlykho/khachhang";
	if($("#makhachhang").val() != "")
		url += "&makhachhang=" + $("#makhachhang").val();
	if($("#hoten").val() != "")
		url += "&hoten="+ $("#hoten").val();
	if($("#khuvuc").val() != "")
		url += "&khuvuc="+ $("#khuvuc").val();
	if($("#loaikhachhang").val() != "")
		url += "&loaikhachhang=" + $("#loaikhachhang").val();	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

function selectKhachHang()
{
	window.opener.document.getElementById('makhachhang').value = $("#selectkhachhang").val();
	window.close();
}

$("#makhachhang").val("<?php echo $_GET['makhachhang']?>");
$("#hoten").val("<?php echo $_GET['hoten']?>");
$("#khuvuc").val("<?php echo $_GET['khuvuc']?>");
$("#loaikhachhang").val("<?php echo $_GET['loaikhachhang']?>");

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectkhachhang").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectkhachhang").val($("#selectkhachhang").val()+","+$(this).val());
				
			}
			
			
		})
		
	});
<?php } ?>
</script>