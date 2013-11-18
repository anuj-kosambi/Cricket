package Box2D.Collision.Shapes
{
    import Box2D.Collision.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2PolygonShape extends b2Shape
    {
        public var m_vertices:Array;
        public var m_normals:Array;
        private var s_supportVec:b2Vec2;
        public var m_obb:b2OBB;
        public var m_coreVertices:Array;
        public var m_centroid:b2Vec2;
        public var m_vertexCount:int;
        private static var s_computeMat:b2Mat22 = new b2Mat22();
        private static var s_sweptAABB1:b2AABB = new b2AABB();
        private static var s_sweptAABB2:b2AABB = new b2AABB();

        public function b2PolygonShape(param1:b2ShapeDef)
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
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
            s_supportVec = new b2Vec2();
            m_obb = new b2OBB();
            m_vertices = new Array(b2Settings.b2_maxPolygonVertices);
            m_normals = new Array(b2Settings.b2_maxPolygonVertices);
            m_coreVertices = new Array(b2Settings.b2_maxPolygonVertices);
            super(param1);
            m_type = e_polygonShape;
            _loc_2 = param1 as b2PolygonDef;
            m_vertexCount = _loc_2.vertexCount;
            _loc_4 = _loc_3;
            _loc_5 = _loc_3;
            _loc_3 = 0;
            while (_loc_3 < m_vertexCount)
            {
                
                m_vertices[_loc_3] = _loc_2.vertices[_loc_3].Copy();
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < m_vertexCount)
            {
                
                _loc_4 = _loc_3;
                _loc_5 = (_loc_3 + 1) < m_vertexCount ? ((_loc_3 + 1)) : (0);
                _loc_6 = m_vertices[_loc_5].x - m_vertices[_loc_4].x;
                _loc_7 = m_vertices[_loc_5].y - m_vertices[_loc_4].y;
                _loc_8 = Math.sqrt(_loc_6 * _loc_6 + _loc_7 * _loc_7);
                m_normals[_loc_3] = new b2Vec2(_loc_7 / _loc_8, (-_loc_6) / _loc_8);
                _loc_3++;
            }
            m_centroid = ComputeCentroid(_loc_2.vertices, _loc_2.vertexCount);
            ComputeOBB(m_obb, m_vertices, m_vertexCount);
            _loc_3 = 0;
            while (_loc_3 < m_vertexCount)
            {
                
                _loc_4 = (_loc_3 - 1) >= 0 ? ((_loc_3 - 1)) : ((m_vertexCount - 1));
                _loc_5 = _loc_3;
                _loc_9 = m_normals[_loc_4].x;
                _loc_10 = m_normals[_loc_4].y;
                _loc_11 = m_normals[_loc_5].x;
                _loc_12 = m_normals[_loc_5].y;
                _loc_13 = m_vertices[_loc_3].x - m_centroid.x;
                _loc_14 = m_vertices[_loc_3].y - m_centroid.y;
                _loc_15 = _loc_9 * _loc_13 + _loc_10 * _loc_14 - b2Settings.b2_toiSlop;
                _loc_16 = _loc_11 * _loc_13 + _loc_12 * _loc_14 - b2Settings.b2_toiSlop;
                _loc_17 = 1 / (_loc_9 * _loc_12 - _loc_10 * _loc_11);
                m_coreVertices[_loc_3] = new b2Vec2(_loc_17 * (_loc_12 * _loc_15 - _loc_10 * _loc_16) + m_centroid.x, _loc_17 * (_loc_9 * _loc_16 - _loc_11 * _loc_15) + m_centroid.y);
                _loc_3++;
            }
            return;
        }// end function

        override public function TestPoint(param1:b2XForm, param2:b2Vec2) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            _loc_4 = param1.R;
            _loc_5 = param2.x - param1.position.x;
            _loc_6 = param2.y - param1.position.y;
            _loc_7 = _loc_5 * _loc_4.col1.x + _loc_6 * _loc_4.col1.y;
            _loc_8 = _loc_5 * _loc_4.col2.x + _loc_6 * _loc_4.col2.y;
            _loc_9 = 0;
            while (_loc_9 < m_vertexCount)
            {
                
                _loc_3 = m_vertices[_loc_9];
                _loc_5 = _loc_7 - _loc_3.x;
                _loc_6 = _loc_8 - _loc_3.y;
                _loc_3 = m_normals[_loc_9];
                _loc_10 = _loc_3.x * _loc_5 + _loc_3.y * _loc_6;
                if (_loc_10 > 0)
                {
                    return false;
                }
                _loc_9++;
            }
            return true;
        }// end function

        public function GetCoreVertices() : Array
        {
            return m_coreVertices;
        }// end function

        override public function TestSegment(param1:b2XForm, param2:Array, param3:b2Vec2, param4:b2Segment, param5:Number) : Boolean
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            _loc_6 = 0;
            _loc_7 = param5;
            _loc_8 = param4.p1.x - param1.position.x;
            _loc_9 = param4.p1.y - param1.position.y;
            _loc_10 = param1.R;
            _loc_12 = _loc_8 * _loc_10.col1.x + _loc_9 * _loc_10.col1.y;
            _loc_13 = _loc_8 * _loc_10.col2.x + _loc_9 * _loc_10.col2.y;
            _loc_8 = param4.p2.x - param1.position.x;
            _loc_9 = param4.p2.y - param1.position.y;
            _loc_10 = param1.R;
            _loc_14 = _loc_8 * _loc_10.col1.x + _loc_9 * _loc_10.col1.y;
            _loc_15 = _loc_8 * _loc_10.col2.x + _loc_9 * _loc_10.col2.y;
            _loc_16 = _loc_14 - _loc_12;
            _loc_17 = _loc_15 - _loc_13;
            _loc_18 = -1;
            _loc_19 = 0;
            while (_loc_19 < m_vertexCount)
            {
                
                _loc_11 = m_vertices[_loc_19];
                _loc_8 = _loc_11.x - _loc_12;
                _loc_9 = _loc_11.y - _loc_13;
                _loc_11 = m_normals[_loc_19];
                _loc_20 = _loc_11.x * _loc_8 + _loc_11.y * _loc_9;
                _loc_21 = _loc_11.x * _loc_16 + _loc_11.y * _loc_17;
                if (_loc_21 < 0 && _loc_20 < _loc_6 * _loc_21)
                {
                    _loc_6 = _loc_20 / _loc_21;
                    _loc_18 = _loc_19;
                }
                else if (_loc_21 > 0 && _loc_20 < _loc_7 * _loc_21)
                {
                    _loc_7 = _loc_20 / _loc_21;
                }
                if (_loc_7 < _loc_6)
                {
                    return false;
                }
                _loc_19++;
            }
            if (_loc_18 >= 0)
            {
                param2[0] = _loc_6;
                _loc_10 = param1.R;
                _loc_11 = m_normals[_loc_18];
                param3.x = _loc_10.col1.x * _loc_11.x + _loc_10.col2.x * _loc_11.y;
                param3.y = _loc_10.col1.y * _loc_11.x + _loc_10.col2.y * _loc_11.y;
                return true;
            }
            return false;
        }// end function

        public function GetCentroid() : b2Vec2
        {
            return m_centroid;
        }// end function

        override public function ComputeMass(param1:b2MassData) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            _loc_2 = 0;
            _loc_3 = 0;
            _loc_4 = 0;
            _loc_5 = 0;
            _loc_6 = 0;
            _loc_7 = 0;
            _loc_8 = 1 / 3;
            _loc_9 = 0;
            while (_loc_9 < m_vertexCount)
            {
                
                _loc_10 = m_vertices[_loc_9];
                _loc_11 = (_loc_9 + 1) < m_vertexCount ? (m_vertices[int((_loc_9 + 1))]) : (m_vertices[0]);
                _loc_12 = _loc_10.x - _loc_6;
                _loc_13 = _loc_10.y - _loc_7;
                _loc_14 = _loc_11.x - _loc_6;
                _loc_15 = _loc_11.y - _loc_7;
                _loc_16 = _loc_12 * _loc_15 - _loc_13 * _loc_14;
                _loc_17 = 0.5 * _loc_16;
                _loc_4 = _loc_4 + _loc_17;
                _loc_2 = _loc_2 + _loc_17 * _loc_8 * (_loc_6 + _loc_10.x + _loc_11.x);
                _loc_3 = _loc_3 + _loc_17 * _loc_8 * (_loc_7 + _loc_10.y + _loc_11.y);
                _loc_18 = _loc_6;
                _loc_19 = _loc_7;
                _loc_20 = _loc_12;
                _loc_21 = _loc_13;
                _loc_22 = _loc_14;
                _loc_23 = _loc_15;
                _loc_24 = _loc_8 * (0.25 * (_loc_20 * _loc_20 + _loc_22 * _loc_20 + _loc_22 * _loc_22) + (_loc_18 * _loc_20 + _loc_18 * _loc_22)) + 0.5 * _loc_18 * _loc_18;
                _loc_25 = _loc_8 * (0.25 * (_loc_21 * _loc_21 + _loc_23 * _loc_21 + _loc_23 * _loc_23) + (_loc_19 * _loc_21 + _loc_19 * _loc_23)) + 0.5 * _loc_19 * _loc_19;
                _loc_5 = _loc_5 + _loc_16 * (_loc_24 + _loc_25);
                _loc_9++;
            }
            param1.mass = m_density * _loc_4;
            _loc_2 = _loc_2 * (1 / _loc_4);
            _loc_3 = _loc_3 * (1 / _loc_4);
            param1.center.Set(_loc_2, _loc_3);
            param1.I = m_density * _loc_5;
            return;
        }// end function

        public function Support(param1:b2XForm, param2:Number, param3:Number) : b2Vec2
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            _loc_5 = param1.R;
            _loc_6 = param2 * _loc_5.col1.x + param3 * _loc_5.col1.y;
            _loc_7 = param2 * _loc_5.col2.x + param3 * _loc_5.col2.y;
            _loc_8 = 0;
            _loc_4 = m_coreVertices[0];
            _loc_9 = _loc_4.x * _loc_6 + _loc_4.y * _loc_7;
            _loc_10 = 1;
            while (_loc_10 < m_vertexCount)
            {
                
                _loc_4 = m_coreVertices[_loc_10];
                _loc_11 = _loc_4.x * _loc_6 + _loc_4.y * _loc_7;
                if (_loc_11 > _loc_9)
                {
                    _loc_8 = _loc_10;
                    _loc_9 = _loc_11;
                }
                _loc_10++;
            }
            _loc_5 = param1.R;
            _loc_4 = m_coreVertices[_loc_8];
            s_supportVec.x = param1.position.x + (_loc_5.col1.x * _loc_4.x + _loc_5.col2.x * _loc_4.y);
            s_supportVec.y = param1.position.y + (_loc_5.col1.y * _loc_4.x + _loc_5.col2.y * _loc_4.y);
            return s_supportVec;
        }// end function

        public function GetVertexCount() : int
        {
            return m_vertexCount;
        }// end function

        override public function ComputeSweptAABB(param1:b2AABB, param2:b2XForm, param3:b2XForm) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_4 = s_sweptAABB1;
            _loc_5 = s_sweptAABB2;
            ComputeAABB(_loc_4, param2);
            ComputeAABB(_loc_5, param3);
            param1.lowerBound.Set(_loc_4.lowerBound.x < _loc_5.lowerBound.x ? (_loc_4.lowerBound.x) : (_loc_5.lowerBound.x), _loc_4.lowerBound.y < _loc_5.lowerBound.y ? (_loc_4.lowerBound.y) : (_loc_5.lowerBound.y));
            param1.upperBound.Set(_loc_4.upperBound.x > _loc_5.upperBound.x ? (_loc_4.upperBound.x) : (_loc_5.upperBound.x), _loc_4.upperBound.y > _loc_5.upperBound.y ? (_loc_4.upperBound.y) : (_loc_5.upperBound.y));
            return;
        }// end function

        public function GetVertices() : Array
        {
            return m_vertices;
        }// end function

        public function GetNormals() : Array
        {
            return m_normals;
        }// end function

        public function GetOBB() : b2OBB
        {
            return m_obb;
        }// end function

        public function GetFirstVertex(param1:b2XForm) : b2Vec2
        {
            return b2Math.b2MulX(param1, m_coreVertices[0]);
        }// end function

        public function Centroid(param1:b2XForm) : b2Vec2
        {
            return b2Math.b2MulX(param1, m_centroid);
        }// end function

        override public function UpdateSweepRadius(param1:b2Vec2) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            m_sweepRadius = 0;
            _loc_3 = 0;
            while (_loc_3 < m_vertexCount)
            {
                
                _loc_2 = m_coreVertices[_loc_3];
                _loc_4 = _loc_2.x - param1.x;
                _loc_5 = _loc_2.y - param1.y;
                _loc_4 = Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
                if (_loc_4 > m_sweepRadius)
                {
                    m_sweepRadius = _loc_4;
                }
                _loc_3++;
            }
            return;
        }// end function

        override public function ComputeAABB(param1:b2AABB, param2:b2XForm) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            _loc_5 = s_computeMat;
            _loc_3 = param2.R;
            _loc_4 = m_obb.R.col1;
            _loc_5.col1.x = _loc_3.col1.x * _loc_4.x + _loc_3.col2.x * _loc_4.y;
            _loc_5.col1.y = _loc_3.col1.y * _loc_4.x + _loc_3.col2.y * _loc_4.y;
            _loc_4 = m_obb.R.col2;
            _loc_5.col2.x = _loc_3.col1.x * _loc_4.x + _loc_3.col2.x * _loc_4.y;
            _loc_5.col2.y = _loc_3.col1.y * _loc_4.x + _loc_3.col2.y * _loc_4.y;
            _loc_5.Abs();
            _loc_6 = _loc_5;
            _loc_4 = m_obb.extents;
            _loc_7 = _loc_6.col1.x * _loc_4.x + _loc_6.col2.x * _loc_4.y;
            _loc_8 = _loc_6.col1.y * _loc_4.x + _loc_6.col2.y * _loc_4.y;
            _loc_3 = param2.R;
            _loc_4 = m_obb.center;
            _loc_9 = param2.position.x + (_loc_3.col1.x * _loc_4.x + _loc_3.col2.x * _loc_4.y);
            _loc_10 = param2.position.y + (_loc_3.col1.y * _loc_4.x + _loc_3.col2.y * _loc_4.y);
            param1.lowerBound.Set(_loc_9 - _loc_7, _loc_10 - _loc_8);
            param1.upperBound.Set(_loc_9 + _loc_7, _loc_10 + _loc_8);
            return;
        }// end function

        public static function ComputeCentroid(param1:Array, param2:int) : b2Vec2
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            _loc_3 = new b2Vec2();
            _loc_4 = 0;
            _loc_5 = 0;
            _loc_6 = 0;
            _loc_7 = 1 / 3;
            _loc_8 = 0;
            while (_loc_8 < param2)
            {
                
                _loc_9 = param1[_loc_8];
                _loc_10 = (_loc_8 + 1) < param2 ? (param1[int((_loc_8 + 1))]) : (param1[0]);
                _loc_11 = _loc_9.x - _loc_5;
                _loc_12 = _loc_9.y - _loc_6;
                _loc_13 = _loc_10.x - _loc_5;
                _loc_14 = _loc_10.y - _loc_6;
                _loc_15 = _loc_11 * _loc_14 - _loc_12 * _loc_13;
                _loc_16 = 0.5 * _loc_15;
                _loc_4 = _loc_4 + _loc_16;
                _loc_3.x = _loc_3.x + _loc_16 * _loc_7 * (_loc_5 + _loc_9.x + _loc_10.x);
                _loc_3.y = _loc_3.y + _loc_16 * _loc_7 * (_loc_6 + _loc_9.y + _loc_10.y);
                _loc_8++;
            }
            _loc_3.x = _loc_3.x * (1 / _loc_4);
            _loc_3.y = _loc_3.y * (1 / _loc_4);
            return _loc_3;
        }// end function

        public static function ComputeOBB(param1:b2OBB, param2:Array, param3:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
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
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = null;
            _loc_5 = new Array((b2Settings.b2_maxPolygonVertices + 1));
            _loc_4 = 0;
            while (_loc_4 < param3)
            {
                
                _loc_5[_loc_4] = param2[_loc_4];
                _loc_4++;
            }
            _loc_5[param3] = _loc_5[0];
            _loc_6 = Number.MAX_VALUE;
            _loc_4 = 1;
            while (_loc_4 <= param3)
            {
                
                _loc_7 = _loc_5[int((_loc_4 - 1))];
                _loc_8 = _loc_5[_loc_4].x - _loc_7.x;
                _loc_9 = _loc_5[_loc_4].y - _loc_7.y;
                _loc_10 = Math.sqrt(_loc_8 * _loc_8 + _loc_9 * _loc_9);
                _loc_8 = _loc_8 / _loc_10;
                _loc_9 = _loc_9 / _loc_10;
                _loc_11 = -_loc_9;
                _loc_12 = _loc_8;
                _loc_13 = Number.MAX_VALUE;
                _loc_14 = Number.MAX_VALUE;
                _loc_15 = -Number.MAX_VALUE;
                _loc_16 = -Number.MAX_VALUE;
                _loc_17 = 0;
                while (_loc_17 < param3)
                {
                    
                    _loc_19 = _loc_5[_loc_17].x - _loc_7.x;
                    _loc_20 = _loc_5[_loc_17].y - _loc_7.y;
                    _loc_21 = _loc_8 * _loc_19 + _loc_9 * _loc_20;
                    _loc_22 = _loc_11 * _loc_19 + _loc_12 * _loc_20;
                    if (_loc_21 < _loc_13)
                    {
                        _loc_13 = _loc_21;
                    }
                    if (_loc_22 < _loc_14)
                    {
                        _loc_14 = _loc_22;
                    }
                    if (_loc_21 > _loc_15)
                    {
                        _loc_15 = _loc_21;
                    }
                    if (_loc_22 > _loc_16)
                    {
                        _loc_16 = _loc_22;
                    }
                    _loc_17++;
                }
                _loc_18 = (_loc_15 - _loc_13) * (_loc_16 - _loc_14);
                if (_loc_18 < 0.95 * _loc_6)
                {
                    _loc_6 = _loc_18;
                    param1.R.col1.x = _loc_8;
                    param1.R.col1.y = _loc_9;
                    param1.R.col2.x = _loc_11;
                    param1.R.col2.y = _loc_12;
                    _loc_23 = 0.5 * (_loc_13 + _loc_15);
                    _loc_24 = 0.5 * (_loc_14 + _loc_16);
                    _loc_25 = param1.R;
                    param1.center.x = _loc_7.x + (_loc_25.col1.x * _loc_23 + _loc_25.col2.x * _loc_24);
                    param1.center.y = _loc_7.y + (_loc_25.col1.y * _loc_23 + _loc_25.col2.y * _loc_24);
                    param1.extents.x = 0.5 * (_loc_15 - _loc_13);
                    param1.extents.y = 0.5 * (_loc_16 - _loc_14);
                }
                _loc_4++;
            }
            return;
        }// end function

    }
}
