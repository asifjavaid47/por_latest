<?php

class ControllerCommonHeader1 extends Controller {

	public function index() {
		$data['text'] = '';
		if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
		$data['base'] = $server;

		return  $this->load->view('common/header1' , $data);
	}
}

