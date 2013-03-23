
<div class="section">

<div class="section-title">Danh sách phiếu thu thập</div>

<div class="section-content">

<form action="" method="post" id="listitem" name="listitem">
<div id="ben-search"><label>Mã phiếu</label> <input type="text"
	id="maphieu" name="maphieu" class="text" /> <label>Ngày lập từ
ngày</label> <script language="javascript">
                    $(function() {
                        $("#tungay").datepicker({
                                changeMonth: true,
                                changeYear: true,
                                dateFormat: 'dd-mm-yy'
                                });
                        });
                 </script> <input type="text" id="tungay" name="tungay"
	class="text" /> <label>đến ngày</label> <script
	language="javascript">
                $(function() {
                    $("#denngay").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script> <input type="text" id="denngay" name="denngay"
	class="text" /> <label>Số lượng sản xuất</label> <input
	type="text" id="soluongsanxuat" name="soluongsanxuat"
	class="text number" /> <br />
<input type="button" class="button" name="btnSearch" value="Tìm"
	onclick="searchForm()" /> <input type="button" class="button"
	name="btnSearch" value="Xem tất cả"
	onclick="window.location = '?route=quanlykho/phieuthuthap'" /></div>
<!-- end search -->

<div class="button right"><input class="button" value="Thêm"
	type="button" onclick="linkto('<?php echo $insert?>')"> <input
	class="button" type="button" name="delete_all" value="Xóa"
	onclick="deleteitem()" /> <input class="button" type="button"
	name="cancel" value="Trở lại"
	onclick="window.location = '?route=quanlykho/phieuthuthap'" /></div>
<div class="clearer">^&nbsp;</div>

<div class="sitemap treeindex">
<table class="data-table" cellpadding="0" cellspacing="0">
	<thead>
		<tr class="tr-head">
		<?php if($this->user->getUserTypeId()=="admin"){?>
			<th width="1%"><input class="inputchk" type="checkbox"
				onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>

				<?php } ?>
			<th>STT</th>
			<th>Số chứng từ</th>
			<th>Công đoạn</th>
			<th>Ngày</th>
			<th>Ca</th>
			<th>Máy</th>
			<th>Số lượng sản xuất</th>
			<th>Nhân viên sản xuất</th>

			<th>Control</th>
		</tr>
	</thead>
	<tbody>


	<?php
	foreach($datas as $key => $item)
	{
		?>

		<tr>
		<?php if($this->user->getUserTypeId()=="admin"){?>
			<td class="check-column"><input class="inputchk" type="checkbox"
				name="delete[<?php echo $item['id']?>]"
				value="<?php echo $item['id']?>"></td>
				<?php } ?>
			<td><?php echo $key+1 ?></td>
			<td><?php echo $item['maphieu']?></td>
			<td><?php echo $this->document->getCongDoan($item['macongdoan'])?></td>
			<td><?php echo $this->date->formatMySQLDate($item['ngay']) ?></td>
			<td><?php echo $item['ca']?></td>
			<td><?php echo $item['may']?></td>
			<td class="number"><?php echo $this->string->numberFormate($item['soluongsanxuat'],0)?></td>
			<td><?php echo $this->document->getNhanVien($item['nhanviensanxuat']) ?></td>

			<td class="link-control"><input type="button" class="button"
				name="btnView" value="<?php echo $item['text_view']?>"
				onclick="window.location='<?php echo $item['link_view']?>'" /> <input
				type="button" class="button" name="btnEdit"
				value="<?php echo $item['text_edit']?>"
				onclick="window.location='<?php echo $item['link_edit']?>'" /></td>
		</tr>
		<?php
	}
	?>


	</tbody>
</table>
</div>
	<?php echo $pager?></form>

</div>

</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/phieuthuthap/delete", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data);
						window.location.reload();
					}
				}
		);
	}
}



function searchForm()
{
	var url =  "?route=quanlykho/phieuthuthap";
	if($("#maphieu").val() != "")
		url += "&maphieu="+ $("#maphieu").val();
	if($("#tungay").val() != "")
		url += "&tungay=" + $("#tungay").val();
	if($("#denngay").val() != "")
		url += "&denngay="+ $("#denngay").val();
	if($("#soluongsanxuat").val() != "")
		url += "&soluongsanxuat="+ $("#soluongsanxuat").val();
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	window.location = url;
}

$("#maphieu").val("<?php echo $_GET['maphieu']?>");
$("#tungay").val("<?php echo $_GET['tungay']?>");
$("#denngay").val("<?php echo $_GET['denngay']?>");
$("#soluongsanxuat").val("<?php echo $_GET['soluongsanxuat']?>");

</script>
