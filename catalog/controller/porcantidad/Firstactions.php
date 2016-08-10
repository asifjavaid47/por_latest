<?php

class ControllerPorcantidadFirstactions extends Controller
{
	public function index()
	{
		echo 'test';
	}
	
	public function getAttributes()
	{
		$cid = $this->customer->getId();
		$post_data = $this->request->post;
		$catId = $post_data['cat_id'];
		$this->load->model('porcantidad/first_features');
		echo json_encode($this->model_porcantidad_first_features->getAttributesByCategory($catId));
	}
}