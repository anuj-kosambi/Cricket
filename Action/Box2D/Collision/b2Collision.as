package Box2D.Collision
{
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2Collision extends Object
    {
        public static const b2_nullFeature:uint = 255;
        private static var b2CollidePolyTempVec:b2Vec2 = new b2Vec2();

        public function b2Collision()
        {
            return;
        }// end function

        public static function EdgeSeparation(param1:b2PolygonShape, param2:b2XForm, param3:int, param4:b2PolygonShape, param5:b2XForm) : Number
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = 0;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            _loc_6 = param1.m_vertexCount;
            _loc_7 = param1.m_vertices;
            _loc_8 = param1.m_normals;
            _loc_9 = param4.m_vertexCount;
            _loc_10 = param4.m_vertices;
            _loc_11 = param2.R;
            _loc_12 = _loc_8[param3];
            _loc_13 = _loc_11.col1.x * _loc_12.x + _loc_11.col2.x * _loc_12.y;
            _loc_14 = _loc_11.col1.y * _loc_12.x + _loc_11.col2.y * _loc_12.y;
            _loc_11 = param5.R;
            _loc_15 = _loc_11.col1.x * _loc_13 + _loc_11.col1.y * _loc_14;
            _loc_16 = _loc_11.col2.x * _loc_13 + _loc_11.col2.y * _loc_14;
            _loc_17 = 0;
            _loc_18 = Number.MAX_VALUE;
            _loc_19 = 0;
            while (_loc_19 < _loc_9)
            {
                
                _loc_12 = _loc_10[_loc_19];
                _loc_25 = _loc_12.x * _loc_15 + _loc_12.y * _loc_16;
                if (_loc_25 < _loc_18)
                {
                    _loc_18 = _loc_25;
                    _loc_17 = _loc_19;
                }
                _loc_19++;
            }
            _loc_12 = _loc_7[param3];
            _loc_11 = param2.R;
            _loc_20 = param2.position.x + (_loc_11.col1.x * _loc_12.x + _loc_11.col2.x * _loc_12.y);
            _loc_21 = param2.position.y + (_loc_11.col1.y * _loc_12.x + _loc_11.col2.y * _loc_12.y);
            _loc_12 = _loc_10[_loc_17];
            _loc_11 = param5.R;
            _loc_22 = param5.position.x + (_loc_11.col1.x * _loc_12.x + _loc_11.col2.x * _loc_12.y);
            _loc_23 = param5.position.y + (_loc_11.col1.y * _loc_12.x + _loc_11.col2.y * _loc_12.y);
            _loc_22 = _loc_22 - _loc_20;
            _loc_23 = _loc_23 - _loc_21;
            _loc_24 = _loc_22 * _loc_13 + _loc_23 * _loc_14;
            return _loc_24;
        }// end function

        public static function b2TestOverlap(param1:b2AABB, param2:b2AABB) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            _loc_3 = param2.lowerBound;
            _loc_4 = param1.upperBound;
            _loc_5 = _loc_3.x - _loc_4.x;
            _loc_6 = _loc_3.y - _loc_4.y;
            _loc_3 = param1.lowerBound;
            _loc_4 = param2.upperBound;
            _loc_7 = _loc_3.x - _loc_4.x;
            _loc_8 = _loc_3.y - _loc_4.y;
            if (_loc_5 > 0 || _loc_6 > 0)
            {
                return false;
            }
            if (_loc_7 > 0 || _loc_8 > 0)
            {
                return false;
            }
            return true;
        }// end function

        public static function FindIncidentEdge(param1:Array, param2:b2PolygonShape, param3:b2XForm, param4:int, param5:b2PolygonShape, param6:b2XForm) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = NaN;
            _loc_7 = param2.m_vertexCount;
            _loc_8 = param2.m_normals;
            _loc_9 = param5.m_vertexCount;
            _loc_10 = param5.m_vertices;
            _loc_11 = param5.m_normals;
            _loc_12 = param3.R;
            _loc_13 = _loc_8[param4];
            _loc_14 = _loc_12.col1.x * _loc_13.x + _loc_12.col2.x * _loc_13.y;
            _loc_15 = _loc_12.col1.y * _loc_13.x + _loc_12.col2.y * _loc_13.y;
            _loc_12 = param6.R;
            _loc_16 = _loc_12.col1.x * _loc_14 + _loc_12.col1.y * _loc_15;
            _loc_15 = _loc_12.col2.x * _loc_14 + _loc_12.col2.y * _loc_15;
            _loc_14 = _loc_16;
            _loc_17 = 0;
            _loc_18 = Number.MAX_VALUE;
            _loc_19 = 0;
            while (_loc_19 < _loc_9)
            {
                
                _loc_13 = _loc_11[_loc_19];
                _loc_23 = _loc_14 * _loc_13.x + _loc_15 * _loc_13.y;
                if (_loc_23 < _loc_18)
                {
                    _loc_18 = _loc_23;
                    _loc_17 = _loc_19;
                }
                _loc_19++;
            }
            _loc_21 = _loc_17;
            _loc_22 = (_loc_21 + 1) < _loc_9 ? ((_loc_21 + 1)) : (0);
            _loc_20 = param1[0];
            _loc_13 = _loc_10[_loc_21];
            _loc_12 = param6.R;
            _loc_20.v.x = param6.position.x + (_loc_12.col1.x * _loc_13.x + _loc_12.col2.x * _loc_13.y);
            _loc_20.v.y = param6.position.y + (_loc_12.col1.y * _loc_13.x + _loc_12.col2.y * _loc_13.y);
            _loc_20.id.features.referenceEdge = param4;
            _loc_20.id.features.incidentEdge = _loc_21;
            _loc_20.id.features.incidentVertex = 0;
            _loc_20 = param1[1];
            _loc_13 = _loc_10[_loc_22];
            _loc_12 = param6.R;
            _loc_20.v.x = param6.position.x + (_loc_12.col1.x * _loc_13.x + _loc_12.col2.x * _loc_13.y);
            _loc_20.v.y = param6.position.y + (_loc_12.col1.y * _loc_13.x + _loc_12.col2.y * _loc_13.y);
            _loc_20.id.features.referenceEdge = param4;
            _loc_20.id.features.incidentEdge = _loc_22;
            _loc_20.id.features.incidentVertex = 1;
            return;
        }// end function

        public static function b2CollidePolygons(param1:b2Manifold, param2:b2PolygonShape, param3:b2XForm, param4:b2PolygonShape, param5:b2XForm) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = null;
            var _loc_33:* = null;
            var _loc_34:* = 0;
            var _loc_35:* = 0;
            var _loc_36:* = 0;
            var _loc_37:* = null;
            var _loc_38:* = NaN;
            var _loc_39:* = null;
            param1.pointCount = 0;
            _loc_7 = 0;
            _loc_8 = [_loc_7];
            _loc_9 = FindMaxSeparation(_loc_8, param2, param3, param4, param5);
            _loc_7 = _loc_8[0];
            if (_loc_9 > 0)
            {
                return;
            }
            _loc_10 = 0;
            _loc_11 = [_loc_10];
            _loc_12 = FindMaxSeparation(_loc_11, param4, param5, param2, param3);
            _loc_10 = _loc_11[0];
            if (_loc_12 > 0)
            {
                return;
            }
            _loc_15 = new b2XForm();
            _loc_16 = new b2XForm();
            _loc_19 = 0.98;
            _loc_20 = 0.001;
            if (_loc_12 > _loc_19 * _loc_9 + _loc_20)
            {
                _loc_13 = param4;
                _loc_14 = param2;
                _loc_15.Set(param5);
                _loc_16.Set(param3);
                _loc_17 = _loc_10;
                _loc_18 = 1;
            }
            else
            {
                _loc_13 = param2;
                _loc_14 = param4;
                _loc_15.Set(param3);
                _loc_16.Set(param5);
                _loc_17 = _loc_7;
                _loc_18 = 0;
            }
            _loc_21 = [new ClipVertex(), new ClipVertex()];
            FindIncidentEdge(_loc_21, _loc_13, _loc_15, _loc_17, _loc_14, _loc_16);
            _loc_22 = _loc_13.m_vertexCount;
            _loc_23 = _loc_13.m_vertices;
            _loc_24 = _loc_23[_loc_17];
            _loc_25 = _loc_24.Copy();
            if ((_loc_17 + 1) < _loc_22)
            {
                _loc_24 = _loc_23[int((_loc_17 + 1))];
                _loc_37 = _loc_24.Copy();
            }
            else
            {
                _loc_24 = _loc_23[0];
                _loc_37 = _loc_24.Copy();
            }
            _loc_26 = b2Math.SubtractVV(_loc_37, _loc_25);
            _loc_27 = b2Math.b2MulMV(_loc_15.R, b2Math.SubtractVV(_loc_37, _loc_25));
            _loc_27.Normalize();
            _loc_28 = b2Math.b2CrossVF(_loc_27, 1);
            _loc_25 = b2Math.b2MulX(_loc_15, _loc_25);
            _loc_37 = b2Math.b2MulX(_loc_15, _loc_37);
            _loc_29 = b2Math.b2Dot(_loc_28, _loc_25);
            _loc_30 = -b2Math.b2Dot(_loc_27, _loc_25);
            _loc_31 = b2Math.b2Dot(_loc_27, _loc_37);
            _loc_32 = [new ClipVertex(), new ClipVertex()];
            _loc_33 = [new ClipVertex(), new ClipVertex()];
            _loc_34 = ClipSegmentToLine(_loc_32, _loc_21, _loc_27.Negative(), _loc_30);
            if (_loc_34 < 2)
            {
                return;
            }
            _loc_34 = ClipSegmentToLine(_loc_33, _loc_32, _loc_27, _loc_31);
            if (_loc_34 < 2)
            {
                return;
            }
            param1.normal = _loc_18 ? (_loc_28.Negative()) : (_loc_28.Copy());
            _loc_35 = 0;
            _loc_36 = 0;
            while (_loc_36 < b2Settings.b2_maxManifoldPoints)
            {
                
                _loc_6 = _loc_33[_loc_36];
                _loc_38 = b2Math.b2Dot(_loc_28, _loc_6.v) - _loc_29;
                if (_loc_38 <= 0)
                {
                    _loc_39 = param1.points[_loc_35];
                    _loc_39.separation = _loc_38;
                    _loc_39.localPoint1 = b2Math.b2MulXT(param3, _loc_6.v);
                    _loc_39.localPoint2 = b2Math.b2MulXT(param5, _loc_6.v);
                    _loc_39.id.key = _loc_6.id._key;
                    _loc_39.id.features.flip = _loc_18;
                    _loc_35++;
                }
                _loc_36++;
            }
            param1.pointCount = _loc_35;
            return;
        }// end function

        public static function FindMaxSeparation(param1:Array, param2:b2PolygonShape, param3:b2XForm, param4:b2PolygonShape, param5:b2XForm) : Number
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_20:* = 0;
            var _loc_21:* = NaN;
            var _loc_22:* = 0;
            var _loc_23:* = NaN;
            var _loc_24:* = 0;
            var _loc_25:* = NaN;
            _loc_6 = param2.m_vertexCount;
            _loc_7 = param2.m_normals;
            _loc_9 = param5.R;
            _loc_8 = param4.m_centroid;
            _loc_10 = param5.position.x + (_loc_9.col1.x * _loc_8.x + _loc_9.col2.x * _loc_8.y);
            _loc_11 = param5.position.y + (_loc_9.col1.y * _loc_8.x + _loc_9.col2.y * _loc_8.y);
            _loc_9 = param3.R;
            _loc_8 = param2.m_centroid;
            _loc_10 = _loc_10 - (param3.position.x + (_loc_9.col1.x * _loc_8.x + _loc_9.col2.x * _loc_8.y));
            _loc_11 = _loc_11 - (param3.position.y + (_loc_9.col1.y * _loc_8.x + _loc_9.col2.y * _loc_8.y));
            _loc_12 = _loc_10 * _loc_9.col1.x + _loc_11 * _loc_9.col1.y;
            _loc_13 = _loc_10 * _loc_9.col2.x + _loc_11 * _loc_9.col2.y;
            _loc_14 = 0;
            _loc_15 = -Number.MAX_VALUE;
            _loc_16 = 0;
            while (_loc_16 < _loc_6)
            {
                
                _loc_8 = _loc_7[_loc_16];
                _loc_25 = _loc_8.x * _loc_12 + _loc_8.y * _loc_13;
                if (_loc_25 > _loc_15)
                {
                    _loc_15 = _loc_25;
                    _loc_14 = _loc_16;
                }
                _loc_16++;
            }
            _loc_17 = EdgeSeparation(param2, param3, _loc_14, param4, param5);
            if (_loc_17 > 0)
            {
                return _loc_17;
            }
            _loc_18 = (_loc_14 - 1) >= 0 ? ((_loc_14 - 1)) : ((_loc_6 - 1));
            _loc_19 = EdgeSeparation(param2, param3, _loc_18, param4, param5);
            if (_loc_19 > 0)
            {
                return _loc_19;
            }
            _loc_20 = (_loc_14 + 1) < _loc_6 ? ((_loc_14 + 1)) : (0);
            _loc_21 = EdgeSeparation(param2, param3, _loc_20, param4, param5);
            if (_loc_21 > 0)
            {
                return _loc_21;
            }
            if (_loc_19 > _loc_17 && _loc_19 > _loc_21)
            {
                _loc_24 = -1;
                _loc_22 = _loc_18;
                _loc_23 = _loc_19;
            }
            else if (_loc_21 > _loc_17)
            {
                _loc_24 = 1;
                _loc_22 = _loc_20;
                _loc_23 = _loc_21;
            }
            else
            {
                param1[0] = _loc_14;
                return _loc_17;
            }
            while (true)
            {
                
                if (_loc_24 == -1)
                {
                    _loc_14 = (_loc_22 - 1) >= 0 ? ((_loc_22 - 1)) : ((_loc_6 - 1));
                }
                else
                {
                    _loc_14 = (_loc_22 + 1) < _loc_6 ? ((_loc_22 + 1)) : (0);
                }
                _loc_17 = EdgeSeparation(param2, param3, _loc_14, param4, param5);
                if (_loc_17 > 0)
                {
                    return _loc_17;
                }
                if (_loc_17 > _loc_23)
                {
                    _loc_22 = _loc_14;
                    _loc_23 = _loc_17;
                    continue;
                }
                break;
            }
            param1[0] = _loc_22;
            return _loc_23;
        }// end function

        public static function ClipSegmentToLine(param1:Array, param2:Array, param3:b2Vec2, param4:Number) : int
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = null;
            var _loc_13:* = null;
            _loc_6 = 0;
            _loc_5 = param2[0];
            _loc_7 = _loc_5.v;
            _loc_5 = param2[1];
            _loc_8 = _loc_5.v;
            _loc_9 = b2Math.b2Dot(param3, _loc_7) - param4;
            _loc_10 = b2Math.b2Dot(param3, _loc_8) - param4;
            if (_loc_9 <= 0)
            {
                param1[++_loc_6] = param2[0];
            }
            if (_loc_10 <= 0)
            {
                param1[++_loc_6] = param2[1];
            }
            if (_loc_9 * _loc_10 < 0)
            {
                _loc_11 = _loc_9 / (_loc_9 - _loc_10);
                _loc_5 = param1[_loc_6];
                _loc_12 = _loc_5.v;
                _loc_12.x = _loc_7.x + _loc_11 * (_loc_8.x - _loc_7.x);
                _loc_12.y = _loc_7.y + _loc_11 * (_loc_8.y - _loc_7.y);
                _loc_5 = param1[_loc_6];
                if (_loc_9 > 0)
                {
                    _loc_13 = param2[0];
                    _loc_5.id = _loc_13.id;
                }
                else
                {
                    _loc_13 = param2[1];
                    _loc_5.id = _loc_13.id;
                }
                _loc_6++;
            }
            return _loc_6;
        }// end function

        public static function b2CollideCircles(param1:b2Manifold, param2:b2CircleShape, param3:b2XForm, param4:b2CircleShape, param5:b2XForm) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = null;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            param1.pointCount = 0;
            _loc_6 = param3.R;
            _loc_7 = param2.m_localPosition;
            _loc_8 = param3.position.x + (_loc_6.col1.x * _loc_7.x + _loc_6.col2.x * _loc_7.y);
            _loc_9 = param3.position.y + (_loc_6.col1.y * _loc_7.x + _loc_6.col2.y * _loc_7.y);
            _loc_6 = param5.R;
            _loc_7 = param4.m_localPosition;
            _loc_10 = param5.position.x + (_loc_6.col1.x * _loc_7.x + _loc_6.col2.x * _loc_7.y);
            _loc_11 = param5.position.y + (_loc_6.col1.y * _loc_7.x + _loc_6.col2.y * _loc_7.y);
            _loc_12 = _loc_10 - _loc_8;
            _loc_13 = _loc_11 - _loc_9;
            _loc_14 = _loc_12 * _loc_12 + _loc_13 * _loc_13;
            _loc_15 = param2.m_radius;
            _loc_16 = param4.m_radius;
            _loc_17 = _loc_15 + _loc_16;
            if (_loc_14 > _loc_17 * _loc_17)
            {
                return;
            }
            if (_loc_14 < Number.MIN_VALUE)
            {
                _loc_18 = -_loc_17;
                param1.normal.Set(0, 1);
            }
            else
            {
                _loc_24 = Math.sqrt(_loc_14);
                _loc_18 = _loc_24 - _loc_17;
                _loc_25 = 1 / _loc_24;
                param1.normal.x = _loc_25 * _loc_12;
                param1.normal.y = _loc_25 * _loc_13;
            }
            param1.pointCount = 1;
            _loc_19 = param1.points[0];
            _loc_19.id.key = 0;
            _loc_19.separation = _loc_18;
            _loc_8 = _loc_8 + _loc_15 * param1.normal.x;
            _loc_9 = _loc_9 + _loc_15 * param1.normal.y;
            _loc_10 = _loc_10 - _loc_16 * param1.normal.x;
            _loc_11 = _loc_11 - _loc_16 * param1.normal.y;
            _loc_20 = 0.5 * (_loc_8 + _loc_10);
            _loc_21 = 0.5 * (_loc_9 + _loc_11);
            _loc_22 = _loc_20 - param3.position.x;
            _loc_23 = _loc_21 - param3.position.y;
            _loc_19.localPoint1.x = _loc_22 * param3.R.col1.x + _loc_23 * param3.R.col1.y;
            _loc_19.localPoint1.y = _loc_22 * param3.R.col2.x + _loc_23 * param3.R.col2.y;
            _loc_22 = _loc_20 - param5.position.x;
            _loc_23 = _loc_21 - param5.position.y;
            _loc_19.localPoint2.x = _loc_22 * _loc_6.col1.x + _loc_23 * _loc_6.col1.y;
            _loc_19.localPoint2.y = _loc_22 * _loc_6.col2.x + _loc_23 * _loc_6.col2.y;
            return;
        }// end function

        public static function b2CollidePolygonAndCircle(param1:b2Manifold, param2:b2PolygonShape, param3:b2XForm, param4:b2CircleShape, param5:b2XForm) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            param1.pointCount = 0;
            _loc_12 = param5.R;
            _loc_11 = param4.m_localPosition;
            _loc_13 = param5.position.x + (_loc_12.col1.x * _loc_11.x + _loc_12.col2.x * _loc_11.y);
            _loc_14 = param5.position.y + (_loc_12.col1.y * _loc_11.x + _loc_12.col2.y * _loc_11.y);
            _loc_7 = _loc_13 - param3.position.x;
            _loc_8 = _loc_14 - param3.position.y;
            _loc_12 = param3.R;
            _loc_15 = _loc_7 * _loc_12.col1.x + _loc_8 * _loc_12.col1.y;
            _loc_16 = _loc_7 * _loc_12.col2.x + _loc_8 * _loc_12.col2.y;
            _loc_18 = 0;
            _loc_19 = -Number.MAX_VALUE;
            _loc_20 = param4.m_radius;
            _loc_21 = param2.m_vertexCount;
            _loc_22 = param2.m_vertices;
            _loc_23 = param2.m_normals;
            _loc_24 = 0;
            while (_loc_24 < _loc_21)
            {
                
                _loc_11 = _loc_22[_loc_24];
                _loc_7 = _loc_15 - _loc_11.x;
                _loc_8 = _loc_16 - _loc_11.y;
                _loc_11 = _loc_23[_loc_24];
                _loc_34 = _loc_11.x * _loc_7 + _loc_11.y * _loc_8;
                if (_loc_34 > _loc_20)
                {
                    return;
                }
                if (_loc_34 > _loc_19)
                {
                    _loc_19 = _loc_34;
                    _loc_18 = _loc_24;
                }
                _loc_24++;
            }
            if (_loc_19 < Number.MIN_VALUE)
            {
                param1.pointCount = 1;
                _loc_11 = _loc_23[_loc_18];
                _loc_12 = param3.R;
                param1.normal.x = _loc_12.col1.x * _loc_11.x + _loc_12.col2.x * _loc_11.y;
                param1.normal.y = _loc_12.col1.y * _loc_11.x + _loc_12.col2.y * _loc_11.y;
                _loc_6 = param1.points[0];
                _loc_6.id.features.incidentEdge = _loc_18;
                _loc_6.id.features.incidentVertex = b2_nullFeature;
                _loc_6.id.features.referenceEdge = 0;
                _loc_6.id.features.flip = 0;
                _loc_9 = _loc_13 - _loc_20 * param1.normal.x;
                _loc_10 = _loc_14 - _loc_20 * param1.normal.y;
                _loc_7 = _loc_9 - param3.position.x;
                _loc_8 = _loc_10 - param3.position.y;
                _loc_12 = param3.R;
                _loc_6.localPoint1.x = _loc_7 * _loc_12.col1.x + _loc_8 * _loc_12.col1.y;
                _loc_6.localPoint1.y = _loc_7 * _loc_12.col2.x + _loc_8 * _loc_12.col2.y;
                _loc_7 = _loc_9 - param5.position.x;
                _loc_8 = _loc_10 - param5.position.y;
                _loc_12 = param5.R;
                _loc_6.localPoint2.x = _loc_7 * _loc_12.col1.x + _loc_8 * _loc_12.col1.y;
                _loc_6.localPoint2.y = _loc_7 * _loc_12.col2.x + _loc_8 * _loc_12.col2.y;
                _loc_6.separation = _loc_19 - _loc_20;
                return;
            }
            _loc_25 = _loc_18;
            _loc_26 = (_loc_25 + 1) < _loc_21 ? ((_loc_25 + 1)) : (0);
            _loc_11 = _loc_22[_loc_25];
            _loc_27 = _loc_22[_loc_26];
            _loc_28 = _loc_27.x - _loc_11.x;
            _loc_29 = _loc_27.y - _loc_11.y;
            _loc_30 = Math.sqrt(_loc_28 * _loc_28 + _loc_29 * _loc_29);
            _loc_28 = _loc_28 / _loc_30;
            _loc_29 = _loc_29 / _loc_30;
            _loc_7 = _loc_15 - _loc_11.x;
            _loc_8 = _loc_16 - _loc_11.y;
            _loc_31 = _loc_7 * _loc_28 + _loc_8 * _loc_29;
            _loc_6 = param1.points[0];
            if (_loc_31 <= 0)
            {
                _loc_32 = _loc_11.x;
                _loc_33 = _loc_11.y;
                _loc_6.id.features.incidentEdge = b2_nullFeature;
                _loc_6.id.features.incidentVertex = _loc_25;
            }
            else if (_loc_31 >= _loc_30)
            {
                _loc_32 = _loc_27.x;
                _loc_33 = _loc_27.y;
                _loc_6.id.features.incidentEdge = b2_nullFeature;
                _loc_6.id.features.incidentVertex = _loc_26;
            }
            else
            {
                _loc_32 = _loc_28 * _loc_31 + _loc_11.x;
                _loc_33 = _loc_29 * _loc_31 + _loc_11.y;
                _loc_6.id.features.incidentEdge = _loc_18;
                _loc_6.id.features.incidentVertex = 0;
            }
            _loc_7 = _loc_15 - _loc_32;
            _loc_8 = _loc_16 - _loc_33;
            _loc_17 = Math.sqrt(_loc_7 * _loc_7 + _loc_8 * _loc_8);
            _loc_7 = _loc_7 / _loc_17;
            _loc_8 = _loc_8 / _loc_17;
            if (_loc_17 > _loc_20)
            {
                return;
            }
            param1.pointCount = 1;
            _loc_12 = param3.R;
            param1.normal.x = _loc_12.col1.x * _loc_7 + _loc_12.col2.x * _loc_8;
            param1.normal.y = _loc_12.col1.y * _loc_7 + _loc_12.col2.y * _loc_8;
            _loc_9 = _loc_13 - _loc_20 * param1.normal.x;
            _loc_10 = _loc_14 - _loc_20 * param1.normal.y;
            _loc_7 = _loc_9 - param3.position.x;
            _loc_8 = _loc_10 - param3.position.y;
            _loc_12 = param3.R;
            _loc_6.localPoint1.x = _loc_7 * _loc_12.col1.x + _loc_8 * _loc_12.col1.y;
            _loc_6.localPoint1.y = _loc_7 * _loc_12.col2.x + _loc_8 * _loc_12.col2.y;
            _loc_7 = _loc_9 - param5.position.x;
            _loc_8 = _loc_10 - param5.position.y;
            _loc_12 = param5.R;
            _loc_6.localPoint2.x = _loc_7 * _loc_12.col1.x + _loc_8 * _loc_12.col1.y;
            _loc_6.localPoint2.y = _loc_7 * _loc_12.col2.x + _loc_8 * _loc_12.col2.y;
            _loc_6.separation = _loc_17 - _loc_20;
            _loc_6.id.features.referenceEdge = 0;
            _loc_6.id.features.flip = 0;
            return;
        }// end function

    }
}
