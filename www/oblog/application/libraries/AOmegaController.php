<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 *  Прототип контроллер в AOmega.Blog
 *
 * @version 1.0
 * @author Ibragimov "MpaK" Renat <info@mrak7.com>
 * @copyright Copyright (c) 2011 http://aomega.ru
 */
class AOmegaController extends MX_Controller{
    protected
        $settings   = array(),  // наши настройки, буду заполнены Core
        $tpl        = '',       // наш собственный шаблонизатор, будет заполнен конструктором
        $env        = '',       // в каком окружении работаем
        $debug      = ''       // работаем ли в дебаге
    ;

    /**
     * Конструктор
     */
    public function __construct(){
        parent::__construct();
        $this->env      = not_empty( $_SERVER['AOMEGA_ENV'], 'production' );
		// dev
		if( $this->env == 'development' ){
			// profile and something else
			$this->output->enable_profiler(TRUE);
			
		}
        //$this->debug    = &$this->settings['site']['debug'];
        //$this->model    = strtolower(get_class($this));
        //$this->tpl      = $this->lib('template')->factory(); // у нас будет свой шаблонизатор
    }
	
}
