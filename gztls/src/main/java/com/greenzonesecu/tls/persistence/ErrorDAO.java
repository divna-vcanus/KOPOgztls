package com.greenzonesecu.tls.persistence;

import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface ErrorDAO {
	public List<DeviceVO> selectErrByTime(Map<String, String> map);
}
