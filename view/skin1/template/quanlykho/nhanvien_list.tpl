<div class="section">

	<div class="section-title">Quản lý danh mục nhân viên</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manhanvien" name="manhanvien" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="hoten" name="hoten" class="text" value="" />
                <label>Phòng ban</label>
                <select id="maphongban" name="maphongban">
                    <option value=""></option>
                    <?php foreach($phongban as $val){ ?>
                    <option value="<?php echo $val['maphongban']?>"><?php echo $val['tenphongban']?></option>
                    <?php } ?>
                </select>
                <label>Chức vụ</label>
                <select id="machucvu" name="machucvu">
                    <option value=""></option>
                    <?php foreach($chucvu as $key => $val){ ?>
                    <option value="<?php echo $key ?>"><?php echo $val ?></option>
                    <?php } ?>
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/nhanvien<?php echo $_GET['opendialog']=='true'?'&opendialog=true':''?>'"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectNhanVien()">
                <input type="hidden" id="selectnhanvien" name="selectnhanvien" />
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
                        <th width="1%">
                        <?php if($dialog==false){ ?>
                        <input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Mã nhân viên</th>
                        <th>Họ tên</th>
                        <th>Phòng ban</th>
                        <th>Chức vụ</th>
                        <th>Chuyên môn</th>
                        <th>Bằng cấp</th>
                        <th>Lương cơ bản</th>
                        <th>Ngạch</th>
                        <th>Thang</th>
                        <th>Hệ số</th>
                        <th>Ngày vào làm</th>
                        <th>Ngày ký hợp đồng</th>
                        <th>BHXH</th>
                        <th>BHYT</th>
                        <th>Tên tài khoản</th>
                        <?php if($dialog==false){ ?>
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
                        <td><?php echo $item['manhanvien']?></td>
                        <td><?php echo $item['hoten']?></td>
                        <td><?php echo $item['tenphongban']?></td>
                        <td><?php echo $this->document->getNhom($item['chucvu'])?></td>
                        <td><?php echo $item['chuyenmon']?></td>
                        <td><?php echo $item['bangcap']?></td>
                        <td><?php echo $this->string->numberFormate($item['luongcoban']) ?></td>
                        <td><?php echo $item['ngach'] ?></td>
                        <td><?php echo $item['thang'] ?></td>
                        <td><?php echo $this->string->numberFormate($item['heso']) ?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngayvaolam'])?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaykyhopdong'])?></td>
                        <td><?php echo $item['bhxh'] ?></td>
                        <td><?php echo $item['bhyt'] ?></td>
                        <td><?php echo $item['username'] ?></td>
                        <?php if($dialog==false){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php if($item['text_phanquyen'] != "") { ?>
                           	<input type="button" class="button" name="btnPhanQuyen" value="<?php echo $item['text_phanquyen']?>" onclick="window.location='<?php echo $item['link_phanquyen']?>'"/>
                            <?php } ?>
                            <input type="button" class="button" name="btnTaiKhoan" value="<?php echo $item['text_taikhoan']?>" onclick="window.location='<?php echo $item['link_taikhoan']?>'"/>
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
		$.post("?route=quanlykho/nhanvien/delete", 
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
	var url =  "?route=quanlykho/nhanvien";
	if($("#manhanvien").val() != "")
		url += "&manhanvien=" + $("#manhanvien").val();
	if($("#hoten").val() != "")
		url += "&hoten="+ $("#hoten").val();
	if($("#maphongban").val() != "")
		url += "&maphongban="+ $("#maphongban").val();
	if($("#machucvu").val() != "")
		url += "&machucvu=" + $("#machucvu").val();	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

function selectNhanVien()
{
	window.opener.document.getElementById('selectnhanvien').value = $("#selectnhanvien").val();
	window.close();
}

$("#manhanvien").val("<?php echo $_GET['manhanvien']?>");
$("#hoten").val("<?php echo $_GET['hoten']?>");
$("#maphongban").val("<?php echo $_GET['maphongban']?>");
$("#machucvu").val("<?php echo $_GET['machucvu']?>");

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnhanvien").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnhanvien").val($("#selectnhanvien").val()+","+$(this).val());
			}
			
			
		})
		
	});
<?php } ?>

</script>