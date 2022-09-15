package org.apache.dubbo.samples.api;

import java.util.Map;

/**
 * @author xiweng.yy
 */
public interface ApisixService {
    
    /**
     * standard samples dubbo infterace demo
     * @param context pass http infos
     * @return Map<String, Object></> pass to response http
     **/
    Map<String, Object> apisixDubbo(Map<String, Object> httpRequestContext);
}
