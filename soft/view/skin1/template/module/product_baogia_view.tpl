<center>
    <h2>Báo giá</h2>
</center>
<table>
	<tr>
        <td align="right">
        	<p>
            	Ngày <?php echo $this->date->getDay($item['ngaybaogia'])?> tháng <?php echo $this->date->getMonth($item['ngaybaogia'])?> năm <?php echo $this->date->getYear($item['ngaybaogia'])?>
            </p>
            
        </td>
    </tr>
    <?php if($item['ghichu']!=""){ ?>
    <tr>
    	<td>
            <div class="cusinfo">
                <?php echo $item['ghichu']?>
            </div>
        </td>
	</tr>
    <?php } ?>
</table>
<table class="table-data">
	<thead>
        <tr>
            <th>STT</th>
            <th>Sản phẩm</th>
			<th>Nhãn hiệu</th>            
            
            <th>Giá</th>
            <th>Hình</th>
        </tr>
    </thead>
    <tbody>
    <?php $index = 1?>
    <?php foreach($sitemaps as $sitemap => $medias){ ?>
    	<?php if(count($medias)){ ?>
    	<tr>
        	<td colspan="5"><strong><?php echo $this->document->getSiteMap($sitemap,SITEID)?></strong></td>
        </tr>
        <?php foreach($medias as $media){?>
        <tr>
        	<td align="center"><?php echo $index++?></td>
            <td>
            	<?php echo $this->document->productName($media)?>
                <?php if($media['ghichu']){ ?>
                (<?php echo $media['ghichu']?>)
                <?php } ?>
            </td>
            <td><font style="text-transform:uppercase"><?php echo $this->document->getCategory($this->document->getMedia($media['mediaid'],'brand'))?></font></td>
            
            <td class="number"><?php echo $this->string->numberFormate($media['gia'])?></td>
            <td><img src="<?php echo $media['imagepreview']?>" /></td>
        </tr>
        <?php }?>
        <?php } ?>
    <?php } ?>
    </tbody>
</table>