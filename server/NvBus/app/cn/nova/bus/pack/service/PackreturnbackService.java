package cn.nova.bus.pack.service;

import cn.nova.bus.pack.model.Packreturnback;
import cn.nova.bus.security.Global;

public interface PackreturnbackService {

	Boolean save(Packreturnback preturnback,Global global);
	
}
