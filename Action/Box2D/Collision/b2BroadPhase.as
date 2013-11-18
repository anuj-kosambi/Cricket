package Box2D.Collision
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2BroadPhase extends Object
    {
        public var m_quantizationFactor:b2Vec2;
        public var m_worldAABB:b2AABB;
        public var m_bounds:Array;
        public var m_freeProxy:uint;
        public var m_proxyCount:int;
        public var m_proxyPool:Array;
        public var m_queryResultCount:int;
        public var m_pairManager:b2PairManager;
        public var m_timeStamp:uint;
        public var m_queryResults:Array;
        public static var s_validate:Boolean = false;
        public static const b2_nullEdge:uint = b2Settings.USHRT_MAX;
        public static const b2_invalid:uint = b2Settings.USHRT_MAX;

        public function b2BroadPhase(param1:b2AABB, param2:b2PairCallback)
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            m_pairManager = new b2PairManager();
            m_proxyPool = new Array(b2Settings.b2_maxPairs);
            m_bounds = new Array(2 * b2Settings.b2_maxProxies);
            m_queryResults = new Array(b2Settings.b2_maxProxies);
            m_quantizationFactor = new b2Vec2();
            m_pairManager.Initialize(this, param2);
            m_worldAABB = param1;
            m_proxyCount = 0;
            _loc_3 = 0;
            while (_loc_3 < b2Settings.b2_maxProxies)
            {
                
                m_queryResults[_loc_3] = 0;
                _loc_3++;
            }
            m_bounds = new Array(2);
            _loc_3 = 0;
            while (_loc_3 < 2)
            {
                
                m_bounds[_loc_3] = new Array(2 * b2Settings.b2_maxProxies);
                _loc_7 = 0;
                while (_loc_7 < 2 * b2Settings.b2_maxProxies)
                {
                    
                    m_bounds[_loc_3][_loc_7] = new b2Bound();
                    _loc_7++;
                }
                _loc_3++;
            }
            _loc_4 = param1.upperBound.x - param1.lowerBound.x;
            _loc_5 = param1.upperBound.y - param1.lowerBound.y;
            m_quantizationFactor.x = b2Settings.USHRT_MAX / _loc_4;
            m_quantizationFactor.y = b2Settings.USHRT_MAX / _loc_5;
            _loc_3 = 0;
            while (_loc_3 < (b2Settings.b2_maxProxies - 1))
            {
                
                _loc_6 = new b2Proxy();
                m_proxyPool[_loc_3] = _loc_6;
                _loc_6.SetNext((_loc_3 + 1));
                _loc_6.timeStamp = 0;
                _loc_6.overlapCount = b2_invalid;
                _loc_6.userData = null;
                _loc_3++;
            }
            _loc_6 = new b2Proxy();
            m_proxyPool[int((b2Settings.b2_maxProxies - 1))] = _loc_6;
            _loc_6.SetNext(b2Pair.b2_nullProxy);
            _loc_6.timeStamp = 0;
            _loc_6.overlapCount = b2_invalid;
            _loc_6.userData = null;
            m_freeProxy = 0;
            m_timeStamp = 1;
            m_queryResultCount = 0;
            return;
        }// end function

        public function QueryAABB(param1:b2AABB, param2, param3:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            _loc_4 = new Array();
            _loc_5 = new Array();
            ComputeBounds(_loc_4, _loc_5, param1);
            _loc_8 = [_loc_6];
            _loc_9 = [_loc_7];
            Query(_loc_8, _loc_9, _loc_4[0], _loc_5[0], m_bounds[0], 2 * m_proxyCount, 0);
            Query(_loc_8, _loc_9, _loc_4[1], _loc_5[1], m_bounds[1], 2 * m_proxyCount, 1);
            _loc_10 = 0;
            _loc_11 = 0;
            while (_loc_11 < m_queryResultCount && _loc_10 < param3)
            {
                
                _loc_12 = m_proxyPool[m_queryResults[_loc_11]];
                param2[_loc_11] = _loc_12.userData;
                _loc_11++;
                _loc_10++;
            }
            m_queryResultCount = 0;
            IncrementTimeStamp();
            return _loc_10;
        }// end function

        public function Commit() : void
        {
            m_pairManager.Commit();
            return;
        }// end function

        public function GetProxy(param1:int) : b2Proxy
        {
            var _loc_2:* = null;
            _loc_2 = m_proxyPool[param1];
            if (param1 == b2Pair.b2_nullProxy || _loc_2.IsValid() == false)
            {
                return null;
            }
            return _loc_2;
        }// end function

        private function IncrementTimeStamp() : void
        {
            var _loc_1:* = 0;
            if (m_timeStamp == b2Settings.USHRT_MAX)
            {
                _loc_1 = 0;
                while (_loc_1 < b2Settings.b2_maxProxies)
                {
                    
                    (m_proxyPool[_loc_1] as b2Proxy).timeStamp = 0;
                    _loc_1 = _loc_1 + 1;
                }
                m_timeStamp = 1;
            }
            else
            {
                var _loc_3:* = m_timeStamp + 1;
                m_timeStamp = _loc_3;
            }
            return;
        }// end function

        private function Query(param1:Array, param2:Array, param3:uint, param4:uint, param5:Array, param6:uint, param7:int) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            _loc_8 = BinarySearch(param5, param6, param3);
            _loc_9 = BinarySearch(param5, param6, param4);
            _loc_11 = _loc_8;
            while (_loc_11 < _loc_9)
            {
                
                _loc_10 = param5[_loc_11];
                if (_loc_10.IsLower())
                {
                    IncrementOverlapCount(_loc_10.proxyId);
                }
                _loc_11 = _loc_11 + 1;
            }
            if (_loc_8 > 0)
            {
                _loc_12 = _loc_8 - 1;
                _loc_10 = param5[_loc_12];
                _loc_13 = _loc_10.stabbingCount;
                while (_loc_13)
                {
                    
                    _loc_10 = param5[_loc_12];
                    if (_loc_10.IsLower())
                    {
                        _loc_14 = m_proxyPool[_loc_10.proxyId];
                        if (_loc_8 <= _loc_14.upperBounds[param7])
                        {
                            IncrementOverlapCount(_loc_10.proxyId);
                            _loc_13 = _loc_13 - 1;
                        }
                    }
                    _loc_12 = _loc_12 - 1;
                }
            }
            param1[0] = _loc_8;
            param2[0] = _loc_9;
            return;
        }// end function

        private function TestOverlapValidate(param1:b2Proxy, param2:b2Proxy) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_3 = 0;
            while (_loc_3 < 2)
            {
                
                _loc_4 = m_bounds[_loc_3];
                _loc_5 = _loc_4[param1.lowerBounds[_loc_3]];
                _loc_6 = _loc_4[param2.upperBounds[_loc_3]];
                if (_loc_5.value > _loc_6.value)
                {
                    return false;
                }
                _loc_5 = _loc_4[param1.upperBounds[_loc_3]];
                _loc_6 = _loc_4[param2.lowerBounds[_loc_3]];
                if (_loc_5.value < _loc_6.value)
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        private function ComputeBounds(param1:Array, param2:Array, param3:b2AABB) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            _loc_4 = param3.lowerBound.x;
            _loc_5 = param3.lowerBound.y;
            _loc_4 = b2Math.b2Min(_loc_4, m_worldAABB.upperBound.x);
            _loc_5 = b2Math.b2Min(_loc_5, m_worldAABB.upperBound.y);
            _loc_4 = b2Math.b2Max(_loc_4, m_worldAABB.lowerBound.x);
            _loc_5 = b2Math.b2Max(_loc_5, m_worldAABB.lowerBound.y);
            _loc_6 = param3.upperBound.x;
            _loc_7 = param3.upperBound.y;
            _loc_6 = b2Math.b2Min(_loc_6, m_worldAABB.upperBound.x);
            _loc_7 = b2Math.b2Min(_loc_7, m_worldAABB.upperBound.y);
            _loc_6 = b2Math.b2Max(_loc_6, m_worldAABB.lowerBound.x);
            _loc_7 = b2Math.b2Max(_loc_7, m_worldAABB.lowerBound.y);
            param1[0] = uint(m_quantizationFactor.x * (_loc_4 - m_worldAABB.lowerBound.x)) & (b2Settings.USHRT_MAX - 1);
            param2[0] = uint(m_quantizationFactor.x * (_loc_6 - m_worldAABB.lowerBound.x)) & 65535 | 1;
            param1[1] = uint(m_quantizationFactor.y * (_loc_5 - m_worldAABB.lowerBound.y)) & (b2Settings.USHRT_MAX - 1);
            param2[1] = uint(m_quantizationFactor.y * (_loc_7 - m_worldAABB.lowerBound.y)) & 65535 | 1;
            return;
        }// end function

        public function CreateProxy(param1:b2AABB, param2) : uint
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = null;
            _loc_5 = m_freeProxy;
            _loc_4 = m_proxyPool[_loc_5];
            m_freeProxy = _loc_4.GetNext();
            _loc_4.overlapCount = 0;
            _loc_4.userData = param2;
            _loc_6 = 2 * m_proxyCount;
            _loc_7 = new Array();
            _loc_8 = new Array();
            ComputeBounds(_loc_7, _loc_8, param1);
            _loc_9 = 0;
            while (_loc_9 < 2)
            {
                
                _loc_11 = m_bounds[_loc_9];
                _loc_14 = [_loc_12];
                _loc_15 = [_loc_13];
                Query(_loc_14, _loc_15, _loc_7[_loc_9], _loc_8[_loc_9], _loc_11, _loc_6, _loc_9);
                _loc_12 = _loc_14[0];
                _loc_13 = _loc_15[0];
                _loc_16 = new Array();
                _loc_18 = _loc_6 - _loc_13;
                _loc_17 = 0;
                while (_loc_17 < _loc_18)
                {
                    
                    _loc_16[_loc_17] = new b2Bound();
                    _loc_19 = _loc_16[_loc_17];
                    _loc_20 = _loc_11[int(_loc_13 + _loc_17)];
                    _loc_19.value = _loc_20.value;
                    _loc_19.proxyId = _loc_20.proxyId;
                    _loc_19.stabbingCount = _loc_20.stabbingCount;
                    _loc_17++;
                }
                _loc_18 = _loc_16.length;
                _loc_22 = _loc_13 + 2;
                _loc_17 = 0;
                while (_loc_17 < _loc_18)
                {
                    
                    _loc_20 = _loc_16[_loc_17];
                    _loc_19 = _loc_11[int(_loc_22 + _loc_17)];
                    _loc_19.value = _loc_20.value;
                    _loc_19.proxyId = _loc_20.proxyId;
                    _loc_19.stabbingCount = _loc_20.stabbingCount;
                    _loc_17++;
                }
                _loc_16 = new Array();
                _loc_18 = _loc_13 - _loc_12;
                _loc_17 = 0;
                while (_loc_17 < _loc_18)
                {
                    
                    _loc_16[_loc_17] = new b2Bound();
                    _loc_19 = _loc_16[_loc_17];
                    _loc_20 = _loc_11[int(_loc_12 + _loc_17)];
                    _loc_19.value = _loc_20.value;
                    _loc_19.proxyId = _loc_20.proxyId;
                    _loc_19.stabbingCount = _loc_20.stabbingCount;
                    _loc_17++;
                }
                _loc_18 = _loc_16.length;
                _loc_22 = _loc_12 + 1;
                _loc_17 = 0;
                while (_loc_17 < _loc_18)
                {
                    
                    _loc_20 = _loc_16[_loc_17];
                    _loc_19 = _loc_11[int(_loc_22 + _loc_17)];
                    _loc_19.value = _loc_20.value;
                    _loc_19.proxyId = _loc_20.proxyId;
                    _loc_19.stabbingCount = _loc_20.stabbingCount;
                    _loc_17++;
                }
                _loc_13 = _loc_13 + 1;
                _loc_19 = _loc_11[_loc_12];
                _loc_20 = _loc_11[_loc_13];
                _loc_19.value = _loc_7[_loc_9];
                _loc_19.proxyId = _loc_5;
                _loc_20.value = _loc_8[_loc_9];
                _loc_20.proxyId = _loc_5;
                _loc_21 = _loc_11[int((_loc_12 - 1))];
                _loc_19.stabbingCount = _loc_12 == 0 ? (0) : (_loc_21.stabbingCount);
                _loc_21 = _loc_11[int((_loc_13 - 1))];
                _loc_20.stabbingCount = _loc_21.stabbingCount;
                _loc_3 = _loc_12;
                while (_loc_3 < _loc_13)
                {
                    
                    _loc_21 = _loc_11[_loc_3];
                    var _loc_24:* = _loc_21;
                    var _loc_25:* = _loc_21.stabbingCount + 1;
                    _loc_24.stabbingCount = _loc_25;
                    _loc_3 = _loc_3 + 1;
                }
                _loc_3 = _loc_12;
                while (_loc_3 < _loc_6 + 2)
                {
                    
                    _loc_19 = _loc_11[_loc_3];
                    _loc_23 = m_proxyPool[_loc_19.proxyId];
                    if (_loc_19.IsLower())
                    {
                        _loc_23.lowerBounds[_loc_9] = _loc_3;
                    }
                    else
                    {
                        _loc_23.upperBounds[_loc_9] = _loc_3;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_9++;
            }
            var _loc_25:* = m_proxyCount + 1;
            m_proxyCount = _loc_25;
            _loc_10 = 0;
            while (_loc_10 < m_queryResultCount)
            {
                
                m_pairManager.AddBufferedPair(_loc_5, m_queryResults[_loc_10]);
                _loc_10++;
            }
            m_pairManager.Commit();
            m_queryResultCount = 0;
            IncrementTimeStamp();
            return _loc_5;
        }// end function

        public function DestroyProxy(param1:uint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            _loc_4 = m_proxyPool[param1];
            _loc_5 = 2 * m_proxyCount;
            _loc_6 = 0;
            while (_loc_6 < 2)
            {
                
                _loc_8 = m_bounds[_loc_6];
                _loc_9 = _loc_4.lowerBounds[_loc_6];
                _loc_10 = _loc_4.upperBounds[_loc_6];
                _loc_2 = _loc_8[_loc_9];
                _loc_11 = _loc_2.value;
                _loc_3 = _loc_8[_loc_10];
                _loc_12 = _loc_3.value;
                _loc_13 = new Array();
                _loc_15 = _loc_10 - _loc_9 - 1;
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_13[_loc_14] = new b2Bound();
                    _loc_2 = _loc_13[_loc_14];
                    _loc_3 = _loc_8[int((_loc_9 + 1) + _loc_14)];
                    _loc_2.value = _loc_3.value;
                    _loc_2.proxyId = _loc_3.proxyId;
                    _loc_2.stabbingCount = _loc_3.stabbingCount;
                    _loc_14++;
                }
                _loc_15 = _loc_13.length;
                _loc_16 = _loc_9;
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_3 = _loc_13[_loc_14];
                    _loc_2 = _loc_8[int(_loc_16 + _loc_14)];
                    _loc_2.value = _loc_3.value;
                    _loc_2.proxyId = _loc_3.proxyId;
                    _loc_2.stabbingCount = _loc_3.stabbingCount;
                    _loc_14++;
                }
                _loc_13 = new Array();
                _loc_15 = _loc_5 - _loc_10 - 1;
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_13[_loc_14] = new b2Bound();
                    _loc_2 = _loc_13[_loc_14];
                    _loc_3 = _loc_8[int((_loc_10 + 1) + _loc_14)];
                    _loc_2.value = _loc_3.value;
                    _loc_2.proxyId = _loc_3.proxyId;
                    _loc_2.stabbingCount = _loc_3.stabbingCount;
                    _loc_14++;
                }
                _loc_15 = _loc_13.length;
                _loc_16 = _loc_10 - 1;
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_3 = _loc_13[_loc_14];
                    _loc_2 = _loc_8[int(_loc_16 + _loc_14)];
                    _loc_2.value = _loc_3.value;
                    _loc_2.proxyId = _loc_3.proxyId;
                    _loc_2.stabbingCount = _loc_3.stabbingCount;
                    _loc_14++;
                }
                _loc_15 = _loc_5 - 2;
                _loc_17 = _loc_9;
                while (_loc_17 < _loc_15)
                {
                    
                    _loc_2 = _loc_8[_loc_17];
                    _loc_19 = m_proxyPool[_loc_2.proxyId];
                    if (_loc_2.IsLower())
                    {
                        _loc_19.lowerBounds[_loc_6] = _loc_17;
                    }
                    else
                    {
                        _loc_19.upperBounds[_loc_6] = _loc_17;
                    }
                    _loc_17 = _loc_17 + 1;
                }
                _loc_15 = _loc_10 - 1;
                _loc_18 = _loc_9;
                while (_loc_18 < _loc_15)
                {
                    
                    _loc_2 = _loc_8[_loc_18];
                    var _loc_20:* = _loc_2;
                    var _loc_21:* = _loc_2.stabbingCount - 1;
                    _loc_20.stabbingCount = _loc_21;
                    _loc_18++;
                }
                Query([0], [0], _loc_11, _loc_12, _loc_8, _loc_5 - 2, _loc_6);
                _loc_6++;
            }
            _loc_7 = 0;
            while (_loc_7 < m_queryResultCount)
            {
                
                m_pairManager.RemoveBufferedPair(param1, m_queryResults[_loc_7]);
                _loc_7++;
            }
            m_pairManager.Commit();
            m_queryResultCount = 0;
            IncrementTimeStamp();
            _loc_4.userData = null;
            _loc_4.overlapCount = b2_invalid;
            _loc_4.lowerBounds[0] = b2_invalid;
            _loc_4.lowerBounds[1] = b2_invalid;
            _loc_4.upperBounds[0] = b2_invalid;
            _loc_4.upperBounds[1] = b2_invalid;
            _loc_4.SetNext(m_freeProxy);
            m_freeProxy = param1;
            var _loc_21:* = m_proxyCount - 1;
            m_proxyCount = _loc_21;
            return;
        }// end function

        public function TestOverlap(param1:b2BoundValues, param2:b2Proxy) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_3 = 0;
            while (_loc_3 < 2)
            {
                
                _loc_4 = m_bounds[_loc_3];
                _loc_5 = _loc_4[param2.upperBounds[_loc_3]];
                if (param1.lowerValues[_loc_3] > _loc_5.value)
                {
                    return false;
                }
                _loc_5 = _loc_4[param2.lowerBounds[_loc_3]];
                if (param1.upperValues[_loc_3] < _loc_5.value)
                {
                    return false;
                }
                _loc_3++;
            }
            return true;
        }// end function

        public function Validate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            _loc_5 = 0;
            while (_loc_5 < 2)
            {
                
                _loc_6 = m_bounds[_loc_5];
                _loc_7 = 2 * m_proxyCount;
                _loc_8 = 0;
                _loc_9 = 0;
                while (_loc_9 < _loc_7)
                {
                    
                    _loc_10 = _loc_6[_loc_9];
                    if (_loc_10.IsLower() == true)
                    {
                        _loc_8 = _loc_8 + 1;
                    }
                    else
                    {
                        _loc_8 = _loc_8 - 1;
                    }
                    _loc_9 = _loc_9 + 1;
                }
                _loc_5++;
            }
            return;
        }// end function

        private function IncrementOverlapCount(param1:uint) : void
        {
            var _loc_2:* = null;
            _loc_2 = m_proxyPool[param1];
            if (_loc_2.timeStamp < m_timeStamp)
            {
                _loc_2.timeStamp = m_timeStamp;
                _loc_2.overlapCount = 1;
            }
            else
            {
                _loc_2.overlapCount = 2;
                m_queryResults[m_queryResultCount] = param1;
                var _loc_4:* = m_queryResultCount + 1;
                m_queryResultCount = _loc_4;
            }
            return;
        }// end function

        public function InRange(param1:b2AABB) : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_2 = param1.lowerBound.x;
            _loc_3 = param1.lowerBound.y;
            _loc_2 = _loc_2 - m_worldAABB.upperBound.x;
            _loc_3 = _loc_3 - m_worldAABB.upperBound.y;
            _loc_4 = m_worldAABB.lowerBound.x;
            _loc_5 = m_worldAABB.lowerBound.y;
            _loc_4 = _loc_4 - param1.upperBound.x;
            _loc_5 = _loc_5 - param1.upperBound.y;
            _loc_2 = b2Math.b2Max(_loc_2, _loc_4);
            _loc_3 = b2Math.b2Max(_loc_3, _loc_5);
            return b2Math.b2Max(_loc_2, _loc_3) < 0;
        }// end function

        public function MoveProxy(param1:uint, param2:b2AABB) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            if (param1 == b2Pair.b2_nullProxy || b2Settings.b2_maxProxies <= param1)
            {
                return;
            }
            if (param2.IsValid() == false)
            {
                return;
            }
            _loc_12 = 2 * m_proxyCount;
            _loc_13 = m_proxyPool[param1];
            _loc_14 = new b2BoundValues();
            ComputeBounds(_loc_14.lowerValues, _loc_14.upperValues, param2);
            _loc_15 = new b2BoundValues();
            _loc_5 = 0;
            while (_loc_5 < 2)
            {
                
                _loc_7 = m_bounds[_loc_5][_loc_13.lowerBounds[_loc_5]];
                _loc_15.lowerValues[_loc_5] = _loc_7.value;
                _loc_7 = m_bounds[_loc_5][_loc_13.upperBounds[_loc_5]];
                _loc_15.upperValues[_loc_5] = _loc_7.value;
                _loc_5 = _loc_5 + 1;
            }
            _loc_5 = 0;
            while (_loc_5 < 2)
            {
                
                _loc_16 = m_bounds[_loc_5];
                _loc_17 = _loc_13.lowerBounds[_loc_5];
                _loc_18 = _loc_13.upperBounds[_loc_5];
                _loc_19 = _loc_14.lowerValues[_loc_5];
                _loc_20 = _loc_14.upperValues[_loc_5];
                _loc_7 = _loc_16[_loc_17];
                _loc_21 = _loc_19 - _loc_7.value;
                _loc_7.value = _loc_19;
                _loc_7 = _loc_16[_loc_18];
                _loc_22 = _loc_20 - _loc_7.value;
                _loc_7.value = _loc_20;
                if (_loc_21 < 0)
                {
                    _loc_6 = _loc_17;
                    while (_loc_6 > 0 && _loc_19 < (_loc_16[int((_loc_6 - 1))] as b2Bound).value)
                    {
                        
                        _loc_7 = _loc_16[_loc_6];
                        _loc_8 = _loc_16[int((_loc_6 - 1))];
                        _loc_23 = _loc_8.proxyId;
                        _loc_24 = m_proxyPool[_loc_8.proxyId];
                        var _loc_25:* = _loc_8;
                        var _loc_26:* = _loc_8.stabbingCount + 1;
                        _loc_25.stabbingCount = _loc_26;
                        if (_loc_8.IsUpper() == true)
                        {
                            if (TestOverlap(_loc_14, _loc_24))
                            {
                                m_pairManager.AddBufferedPair(param1, _loc_23);
                            }
                            _loc_3 = _loc_24.upperBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 + 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount + 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        else
                        {
                            _loc_3 = _loc_24.lowerBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 + 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount - 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        _loc_3 = _loc_13.lowerBounds;
                        _loc_4 = _loc_3[_loc_5];
                        _loc_4 = _loc_4 - 1;
                        _loc_3[_loc_5] = _loc_4;
                        _loc_7.Swap(_loc_8);
                        _loc_6 = _loc_6 - 1;
                    }
                }
                if (_loc_22 > 0)
                {
                    _loc_6 = _loc_18;
                    while (_loc_6 < (_loc_12 - 1) && (_loc_16[int((_loc_6 + 1))] as b2Bound).value <= _loc_20)
                    {
                        
                        _loc_7 = _loc_16[_loc_6];
                        _loc_9 = _loc_16[int((_loc_6 + 1))];
                        _loc_10 = _loc_9.proxyId;
                        _loc_11 = m_proxyPool[_loc_10];
                        var _loc_25:* = _loc_9;
                        var _loc_26:* = _loc_9.stabbingCount + 1;
                        _loc_25.stabbingCount = _loc_26;
                        if (_loc_9.IsLower() == true)
                        {
                            if (TestOverlap(_loc_14, _loc_11))
                            {
                                m_pairManager.AddBufferedPair(param1, _loc_10);
                            }
                            _loc_3 = _loc_11.lowerBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 - 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount + 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        else
                        {
                            _loc_3 = _loc_11.upperBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 - 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount - 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        _loc_3 = _loc_13.upperBounds;
                        _loc_4 = _loc_3[_loc_5];
                        _loc_4 = _loc_4 + 1;
                        _loc_3[_loc_5] = _loc_4;
                        _loc_7.Swap(_loc_9);
                        _loc_6 = _loc_6 + 1;
                    }
                }
                if (_loc_21 > 0)
                {
                    _loc_6 = _loc_17;
                    while (_loc_6 < (_loc_12 - 1) && (_loc_16[int((_loc_6 + 1))] as b2Bound).value <= _loc_19)
                    {
                        
                        _loc_7 = _loc_16[_loc_6];
                        _loc_9 = _loc_16[int((_loc_6 + 1))];
                        _loc_10 = _loc_9.proxyId;
                        _loc_11 = m_proxyPool[_loc_10];
                        var _loc_25:* = _loc_9;
                        var _loc_26:* = _loc_9.stabbingCount - 1;
                        _loc_25.stabbingCount = _loc_26;
                        if (_loc_9.IsUpper())
                        {
                            if (TestOverlap(_loc_15, _loc_11))
                            {
                                m_pairManager.RemoveBufferedPair(param1, _loc_10);
                            }
                            _loc_3 = _loc_11.upperBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 - 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount - 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        else
                        {
                            _loc_3 = _loc_11.lowerBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 - 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount + 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        _loc_3 = _loc_13.lowerBounds;
                        _loc_4 = _loc_3[_loc_5];
                        _loc_4 = _loc_4 + 1;
                        _loc_3[_loc_5] = _loc_4;
                        _loc_7.Swap(_loc_9);
                        _loc_6 = _loc_6 + 1;
                    }
                }
                if (_loc_22 < 0)
                {
                    _loc_6 = _loc_18;
                    while (_loc_6 > 0 && _loc_20 < (_loc_16[int((_loc_6 - 1))] as b2Bound).value)
                    {
                        
                        _loc_7 = _loc_16[_loc_6];
                        _loc_8 = _loc_16[int((_loc_6 - 1))];
                        _loc_23 = _loc_8.proxyId;
                        _loc_24 = m_proxyPool[_loc_23];
                        var _loc_25:* = _loc_8;
                        var _loc_26:* = _loc_8.stabbingCount - 1;
                        _loc_25.stabbingCount = _loc_26;
                        if (_loc_8.IsLower() == true)
                        {
                            if (TestOverlap(_loc_15, _loc_24))
                            {
                                m_pairManager.RemoveBufferedPair(param1, _loc_23);
                            }
                            _loc_3 = _loc_24.lowerBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 + 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount - 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        else
                        {
                            _loc_3 = _loc_24.upperBounds;
                            _loc_4 = _loc_3[_loc_5];
                            _loc_4 = _loc_4 + 1;
                            _loc_3[_loc_5] = _loc_4;
                            var _loc_25:* = _loc_7;
                            var _loc_26:* = _loc_7.stabbingCount + 1;
                            _loc_25.stabbingCount = _loc_26;
                        }
                        _loc_3 = _loc_13.upperBounds;
                        _loc_4 = _loc_3[_loc_5];
                        _loc_4 = _loc_4 - 1;
                        _loc_3[_loc_5] = _loc_4;
                        _loc_7.Swap(_loc_8);
                        _loc_6 = _loc_6 - 1;
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public static function BinarySearch(param1:Array, param2:int, param3:uint) : uint
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            _loc_4 = 0;
            _loc_5 = param2 - 1;
            while (_loc_4 <= _loc_5)
            {
                
                _loc_6 = (_loc_4 + _loc_5) / 2;
                _loc_7 = param1[_loc_6];
                if (_loc_7.value > param3)
                {
                    _loc_5 = _loc_6 - 1;
                    continue;
                }
                if (_loc_7.value < param3)
                {
                    _loc_4 = _loc_6 + 1;
                    continue;
                }
                return uint(_loc_6);
            }
            return uint(_loc_4);
        }// end function

    }
}
