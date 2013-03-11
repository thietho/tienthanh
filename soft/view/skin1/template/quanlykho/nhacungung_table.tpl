<table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%"><input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                        <th>STT</th>
                        <th>Mã nhà cung ứng</th>
                        <th>Tên nhà cung ứng</th>
                        <th>Địa chỉ</th>
                        <th>Điện thoại</th>
                        <th>Fax</th>
                        <th>Người đại diện</th>
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
            
        	<?php echo $pager?>
<script language="javascript">
$('#inputchk').click(function(e) {
	var chk=this.checked;
    $('.inputchk').each(function(index, element) {
        this.checked = chk;
    });
});
</script>