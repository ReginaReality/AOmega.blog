<?php (defined('BASEPATH')) OR exit('No direct script access allowed');


class MX_Lang extends CI_Lang{
	public function load($langfile, $lang = '', $return = FALSE, $add_suffix = TRUE, $alt_path = '')	{
		
		if (is_array($langfile)) {
			foreach($langfile as $_lang) $this->load($_lang);
			return $this->language;
		}
			
		$deft_lang = CI::$APP->config->item('language');
		$idiom = ($lang == '') ? $deft_lang : $lang;
	
		if (in_array($langfile.'_lang'.EXT, $this->is_loaded, TRUE))
			return $this->language;
	
		$_module = CI::$APP->router->fetch_module();
		list($path, $_langfile) = Modules::find($langfile.'_lang', $_module, 'language/'.$idiom.'/');

		if ($path === FALSE) {
			if ($lang = parent::load($langfile, $lang, $return, $add_suffix, $alt_path)) return $lang;
		} else {
			if($lang = Modules::load_file($_langfile, $path, 'lang')) {
				if ($return) return $lang;
				$this->language = array_merge($this->language, $lang);
				$this->is_loaded[] = $langfile.'_lang'.EXT;
				unset($lang);
			}
		}
		
		return $this->language;
	}
}