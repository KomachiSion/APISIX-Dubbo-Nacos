/*
 *
 *   Licensed to the Apache Software Foundation (ASF) under one or more
 *   contributor license agreements.  See the NOTICE file distributed with
 *   this work for additional information regarding copyright ownership.
 *   The ASF licenses this file to You under the Apache License, Version 2.0
 *   (the "License"); you may not use this file except in compliance with
 *   the License.  You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.apache.dubbo.samples.provider.impl;

import org.apache.dubbo.config.annotation.Service;
import org.apache.dubbo.samples.api.ApisixService;

import java.util.HashMap;
import java.util.Map;

@Service(version = "1.0.0")
public class AnnotatedApisixService implements ApisixService {
    
    @Override
    public Map<String, Object> apisixDubbo(Map<String, Object> httpRequestContext) {
        for (Map.Entry<String, Object> entry : httpRequestContext.entrySet()) {
            System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
        }
        
        Map<String, Object> ret = new HashMap<String, Object>(3);
        ret.put("body", "dubbo success\n"); // http response body
        ret.put("status", "200"); // http response status
        ret.put("test", "123"); // http response header
        
        return ret;
    }
}
