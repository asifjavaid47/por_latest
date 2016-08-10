<?php

class ModelPorcantidadFirstfeatures extends Model
{
	
	public function getAttributesByCategory($category_id)
	{
		$query = $this->db->query("
					SELECT ag.attribute_group_id, agd.name as attribute, a.attribute_id, ad.name as attribute_value 
					FROM oc_attribute a
						inner join oc_attribute_description ad on a.attribute_id = ad.attribute_id
						inner join oc_attribute_group ag on a.attribute_group_id = ag.attribute_group_id
						inner join oc_attribute_group_description agd on a.attribute_group_id = agd.attribute_group_id
					where 
						ad.language_id = 1 and agd.language_id = 1 and
						a.attribute_group_id in (select cag.attribute_group_id from oc_category_attribute_group cag where cag.category_id=".$category_id.")
					order by 
						ag.attribute_group_id;");

		return $query->rows;
	}
}