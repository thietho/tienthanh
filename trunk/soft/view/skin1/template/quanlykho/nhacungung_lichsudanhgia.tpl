<div class="section">

	<div class="section-title">Lịch sử đánh giá nhà cung ứng</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listitem" name="listitem">
        	<div id="ben-search">
            	<label>Mã NCC:</label>
                <?php echo $item['manhacungung']?>
        		<label>Mã NCC:</label>
                <?php echo $item['tennhacungung']?>
            </div>
        	<div class="button right">
                <input class="button" value="Add new" type="button" onclick="linkto('<?php echo $insert?>')">
            	
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                       
                        <th>STT</th>
                        <th>Ngày đánh giá</th>
                        <th>Số lượng</th>
                        <th>Chất lượng</th>
                        <th>Thời gian cung ứng</th>
                        <th>Thanh toán</th>
                       
                        
                                               
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($danhgia as $key => $item)
            {
        ?>
                    <tr>
                        
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaydanhgia'])?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiasoluong']]?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiachatluong']]?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiathoigian']]?></td>
                        <td><?php echo $this->document->danhgia[$item['danhgiathanhtoan']]?></td>
                        
                       
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


</script>