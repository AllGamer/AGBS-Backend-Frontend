<?php

class Api extends CI_Controller {

	function __construct()
	{
		parent::__construct();
		$this->load->model('Server');
		$this->_get_output_type();
		file_put_contents('/tmp/debug.boom.in.txt', serialize($_REQUEST));
	}
	
	function _output($output)
	{
		// Final processing.
		$outputtype = $this->_get_output_type();
		if ($outputtype == 'ser')
		{
			echo $output;
		}
		elseif ($outputtype = 'json')
		{
			echo json_encode(unserialize($output));
		}
		elseif ($outputtype = 'xml')
		{
			echo '<?xml version="1.0"><output><status>fail</status><reason>Unimplemented.</reason></output>';
		}
		file_put_contents('/tmp/debug.boom.out.txt', $output);
	}
	
	private function _get_output_type()
	{
		$uri = $this->uri->uri_string();
		$ext = pathinfo($uri, PATHINFO_EXTENSION);
		$outputs = array('json' => true, 'xml' => true, 'ser' => true);
		if (isset($outputs[$ext])) return $ext;
		show_error('Output format not valid!', 403);
	}
	
	private function _check_apikey()
	{
		$apikey = $this->input->get_post('apikey');
		if ($apikey === FALSE)
		{
			show_error('API key required!', 403);
			return false;
		}
		$r = $this->Server->load_api_key($apikey);
		if (Server::NO_SERVER == $r)
		{
			show_error('API key invalid!', 403);
			return false;
		}
		return true; // SUCCESS
	}

	function heartbeat()
	{
		if (!$this->_check_apikey()) return false; // Check API key validity
		$outputdata = array('status' => 'fail', 'reason' => 'nyi');
		$this->output->set_output(serialize($outputdata));
	}
}
