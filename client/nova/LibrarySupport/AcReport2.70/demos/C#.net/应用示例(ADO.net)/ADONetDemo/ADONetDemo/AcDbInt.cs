using System;
using System.Data;
using System.Collections;
using ADODB;

/// <summary>
/// Summary description for Class1
/// </summary>
/// 
namespace AcReport
{
    public class AcProxProps : Object, ADODB.Properties
    {

        #region IAcDbProps 成员

        public int Count
        {
            get { return 0; }
        }

        public System.Collections.IEnumerator GetEnumerator()
        {
            return null;
        }

        public void Refresh()
        {
            
        }

        public Property this[object Index]
        {
            get { return null; }
        }

        #endregion
    }

    public class AcProxField: Object, ADODB.Field
    {
        private DataColumn FInnerField = null;
        private int Index = 0;
        private AcProxProps FProps = new AcProxProps();
        private AcProxRecordset OwnerRecordset = null;

        public AcProxField(DataColumn oInnerField, int nIndex, AcProxRecordset oOwnerRecordset)
        {
            //
            // TODO: Add constructor logic here
            //
            FInnerField = oInnerField;
            Index = nIndex;
            OwnerRecordset = oOwnerRecordset;
        }


       DataTypeEnum FieldTypeToADOType(Type FieldType)
      {

          if (FieldType == typeof(object)) return DataTypeEnum.adVariant;
          else
              if (FieldType == typeof(string)) return DataTypeEnum.adVarChar;
              else
                  if (FieldType == typeof(short)) return DataTypeEnum.adSmallInt;
                  else
                      if (FieldType == typeof(Int16)) return DataTypeEnum.adUnsignedSmallInt;
                      else
                          if (FieldType == typeof(int)) return DataTypeEnum.adInteger;
                          else
                              if (FieldType == typeof(Int32)) return DataTypeEnum.adInteger;
                              else
                                  if (FieldType == typeof(Boolean)) return DataTypeEnum.adBoolean;
                                  else
                                      if (FieldType == typeof(bool)) return DataTypeEnum.adBoolean;
                                      else
                                          if (FieldType == typeof(float)) return DataTypeEnum.adDouble;
                                          else
                                              if (FieldType == typeof(DateTime)) return DataTypeEnum.adDBDate;
                                              else
                                                  if (FieldType == typeof(Array)) return DataTypeEnum.adBinary;
                                                  else

                                                      return DataTypeEnum.adEmpty;

    /*
    ftVarBytes: return DataTypeEnum.adVarBinary;
    ftBlob, ftGraphic..ftTypedBinary: return DataTypeEnum.adLongVarBinary;
    ftFixedChar: return DataTypeEnum.adChar;
    ftLargeint: return DataTypeEnum.adBigInt;
    ftVariant: return DataTypeEnum.adVariant;
    ftInterface: return DataTypeEnum.adIUnknown;
    ftIDispatch: return DataTypeEnum.adIDispatch;
    ftGuid: return DataTypeEnum.adGUID;
  else
    DatabaseErrorFmt('未知的类型', [FieldTypeNames[FieldType]]);
    return DataTypeEnum.adEmpty;
     
     */

    }


        #region IAcField 成员

        public int ActualSize
        {
            get { return FInnerField.MaxLength; }
        }

        public void AppendChunk(object Data)
        {
            
        }

        public int Attributes
        {
            get
            {
                return 0;
            }
            set
            {
                
            }
        }

        public object DataFormat
        {
            get
            {
                return 0;
            }
            set
            {
                
            }
        }

        public int DefinedSize
        {
            get
            {
                return FInnerField.MaxLength;
            }
            set
            {
                
            }
        }

        public object GetChunk(int Length)
        {
            return null;
        }

        public string Name
        {
            get { return FInnerField.ColumnName; }
        }

        public byte NumericScale
        {
            get
            {
                return 10; //最大小数位数
            }
            set
            {
                
            }
        }

        public object OriginalValue
        {
            get { return 0; }
        }

        public byte Precision
        {
            get
            {
                return 0;
            }
            set
            {
                
            }
        }

        public Properties Properties
        {
            get { return FProps; }
        }

        public DataTypeEnum Type
        {
            get
            {
                return FieldTypeToADOType(FInnerField.DataType);
            }
            set
            {
               
            }
        }

        public object UnderlyingValue
        {
            get { return 0; }
        }

        public object Value
        {
            get
            {
                DataRow oCurRow = OwnerRecordset.CurRow();
                if (oCurRow != null)
                    return oCurRow[this.Index];
                else
                    return null;
            }
            set
            {
                DataRow oCurRow = OwnerRecordset.CurRow();
                if (oCurRow != null)
                    oCurRow[this.Index] = value;
            }
        }

        #endregion

        #region Field 成员


        public int Status
        {
            get { throw new Exception("The method or operation is not implemented."); }
        }

        #endregion
    }

    public class AcProxFields : Object, ADODB.Fields
    {
        public DataColumnCollection Columns = null;
        public AcProxRecordset OwnerRecordset = null;
        private System.Collections.Generic.List<AcProxField> FieldList = new System.Collections.Generic.List<AcProxField>();

        public AcProxFields(AcProxRecordset oOwnerRecordset)
        {
            OwnerRecordset = oOwnerRecordset;
            Columns = OwnerRecordset.InnerTable.Columns;
            RefreshFieldList();
        }

       private void RefreshFieldList()
       {
           FieldList.Clear();
           for(int i = 0; i <= Columns.Count - 1; i++)
           {
               AcProxField aField = new AcProxField(Columns[i], i, OwnerRecordset);
               FieldList.Add(aField);
           }
       }

       #region IAcFields 成员

       public void Append(string Name, DataTypeEnum Type, int DefinedSize, FieldAttributeEnum Attrib)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public int Count
        {
            get { return FieldList.Count; }
        }

        public void Delete(object Index)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public System.Collections.IEnumerator GetEnumerator()
        {
            return null;  //throw new Exception("The method or operation is not implemented.");
        }

        public void Refresh()
        {
            RefreshFieldList();
        }

        public Field this[object Index]
        {
            get 
            {
                int i = (int)Index;
                return FieldList[i]; 
            }
        }

        #endregion

        #region Fields 成员

        public void Append(string Name, DataTypeEnum Type, int DefinedSize, FieldAttributeEnum Attrib, object FieldValue)
        {
            //throw new Exception("The method or operation is not implemented.");
        }

        public void CancelUpdate()
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public void Resync(ResyncEnum ResyncValues)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public void Update()
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public void _Append(string Name, DataTypeEnum Type, int DefinedSize, FieldAttributeEnum Attrib)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        #endregion
    }

    public class AcProxRecordset : Object, ADODB.Recordset
    {
        public DataRowCollection Rows = null;
        public DataTable InnerTable = null;
        public AcProxFields ProxFields = null;
        private int CurRownIndex = 0;
        private PositionEnum PosState = PositionEnum.adPosUnknown;
        private AcProxProps Props = new AcProxProps();
       

        public AcProxRecordset(DataTable oTable)
        {
            InnerTable = oTable;
            Rows = oTable.Rows;
            ProxFields = new AcProxFields(this);
        }

        public DataRow CurRow()
        {
            if (Rows.Count <= 0)
                return null;
            else
                return Rows[CurRownIndex];
        }

        #region IAcRecord 成员

        public PositionEnum AbsolutePage
        {
            get
            {
                return PosState;  // throw new Exception("The method or operation is not implemented.");
            }
            set
            {
                //throw new Exception("The method or operation is not implemented.");
            }
        }

        public PositionEnum AbsolutePosition
        {
            get
            {
                return PosState;  //throw new Exception("The method or operation is not implemented.");
            }
            set
            {
                //throw new Exception("The method or operation is not implemented.");
            }
        }

        public object ActiveCommand
        {
            get { return this; }
        }

        public object ActiveConnection
        {
            get
            {
                return null; // throw new Exception("The method or operation is not implemented.");
            }
            set
            {
                //throw new Exception("The method or operation is not implemented.");
            }
        }

        public void AddNew(object FieldList, object Values)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public bool BOF
        {
            get { return (PosState == PositionEnum.adPosBOF); }
        }

        public object Bookmark
        {
            get
            {
                return this.CurRownIndex;
            }
            set
            {
                int i = (int)value;
                if (i >= 0 && i <= Rows.Count - 1)
                  this.CurRownIndex = i;
            }
        }

        public int CacheSize
        {
            get
            {
                return 0;
            }
            set
            {
                //throw new Exception("The method or operation is not implemented.");
            }
        }

        public void Cancel()
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public void CancelBatch(AffectEnum AffectRecords)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public void CancelUpdate()
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public Recordset Clone(LockTypeEnum LockType)
        {
            return null;
        }

        public void Close()
        {
            
        }

        public CompareEnum CompareBookmarks(object Bookmark1, object Bookmark2)
        {
            int b1 = (int)Bookmark1, b2 = (int)Bookmark2;
            if (b1 == b2)
                return CompareEnum.adCompareEqual;
            else if (b1 > b2)
                return CompareEnum.adCompareGreaterThan;
            else
                return CompareEnum.adCompareLessThan;
               
        }

        public CursorLocationEnum CursorLocation
        {
            get
            {
                return CursorLocationEnum.adUseClient;
            }
            set
            {
               // throw new Exception("The method or operation is not implemented.");
            }
        }

        public CursorTypeEnum CursorType
        {
            get
            {
                return CursorTypeEnum.adOpenKeyset;
            }
            set
            {
               // throw new Exception("The method or operation is not implemented.");
            }
        }

        public string DataMember
        {
            get
            {
                return ""; //throw new Exception("The method or operation is not implemented.");
            }
            set
            {
               // throw new Exception("The method or operation is not implemented.");
            }
        }

        public object DataSource
        {
            get
            {
                return null; // throw new Exception("The method or operation is not implemented.");
            }
            set
            {
              //  throw new Exception("The method or operation is not implemented.");
            }
        }

        public void Delete(AffectEnum AffectRecords)
        {
           // throw new Exception("The method or operation is not implemented.");
        }

        public bool EOF
        {
            get { return (PositionEnum.adPosEOF == PosState); }
        }

        public EditModeEnum EditMode
        {
            get { return EditModeEnum.adEditNone; }
        }

        public Fields Fields
        {
            get { return this.ProxFields; }
        }

        public object Filter
        {
            get
            {
                return InnerTable.DefaultView.RowFilter;
            }
            set
            {
                InnerTable.DefaultView.RowFilter = (string)value;
            }
        }

        public void Find(string Criteria, int SkipRecords, SearchDirectionEnum SearchDirection, object Start)
        {
            
        }

        public object GetRows(int Rows, object Start, object Fields)
        {
            return null;
        }

        public string GetString(StringFormatEnum StringFormat, int NumRows, string ColumnDelimeter, string RowDelimeter, string NullExpr)
        {
            return "";
        }

        public string Index
        {
            get
            {
                return "";
            }
            set
            {
                
            }
        }

        public LockTypeEnum LockType
        {
            get
            {
                return LockTypeEnum.adLockOptimistic;
            }
            set
            {
                
            }
        }

        public MarshalOptionsEnum MarshalOptions
        {
            get
            {
                return MarshalOptionsEnum.adMarshalModifiedOnly;
            }
            set
            {
                
            }
        }

        public int MaxRecords
        {
            get
            {
                return 9999999;
            }
            set
            {
                
            }
        }

        public void Move(int NumRecords, object Start)
        {
            if (NumRecords <= Rows.Count && NumRecords >= 0)
              CurRownIndex = NumRecords;
        }

        public void MoveFirst()
        {
            CurRownIndex = 0;
            PosState = PositionEnum.adPosUnknown;
        }

        public void MoveLast()
        {
            CurRownIndex = Rows.Count - 1;
            PosState = PositionEnum.adPosUnknown;
        }

        public void MoveNext()
        {
            PosState = PositionEnum.adPosUnknown;
            if (CurRownIndex < Rows.Count - 1)           
                CurRownIndex++;          
            else
            {
                CurRownIndex = Rows.Count - 1;
                PosState = PositionEnum.adPosEOF;
            }
        }

        public void MovePrevious()
        {
            PosState = PositionEnum.adPosUnknown;
            if (CurRownIndex > 0)
                CurRownIndex --;
            else 
            {
                CurRownIndex = 0;
                PosState = PositionEnum.adPosBOF;
            }
        }

        public Recordset NextRecordset(out object RecordsAffected)
        {
            RecordsAffected = 0;
            return null;
        }

        public void Open(object Source, object ActiveConnection, CursorTypeEnum CursorType, LockTypeEnum LockType, int Options)
        {
            
        }

        public int PageCount
        {
            get { return 0; }
        }

        public int PageSize
        {
            get
            {
                return 0;
            }
            set
            {
                
            }
        }

        public Properties Properties
        {
            get { return Props; }
        }

        public int RecordCount
        {
            get { return Rows.Count; }
        }

        public void Requery(int Options)
        {
            
        }

        public void Resync(AffectEnum AffectRecords, ResyncEnum ResyncValues)
        {
            
        }

        public void Save(string FileName, PersistFormatEnum PersistFormat)
        {
            
        }

        public void Seek(object KeyValues, SeekEnum SeekOption)
        {
            
        }

        public string Sort
        {
            get
            {
                return "";
            }
            set
            {
                
            }
        }

        public object Source
        {
            get
            {
                return null;
            }
            set
            {
               
            }
        }

        public int State
        {
            get 
            { 
               // int n = 0;
               // if (Rows.Count > 0)
                 //   n = n | 1; // adStateOpen;
                return 1;
            }
        }
        
        public int Status
        {
            get { return 0; }
        }

        public bool StayInSync
        {
            get
            {
                return false;
            }
            set
            {
                
            }
        }

        public bool Supports(CursorOptionEnum CursorOptions)
        {
            return true;
        }

        public void Update(object Fields, object Values)
        {
            
        }

        public void UpdateBatch(AffectEnum AffectRecords)
        {
            
        }

        public Recordset _xClone()
        {
            return (Recordset)this;
        }

        public void _xResync(AffectEnum AffectRecords)
        {
            
        }

        public object get_Collect(object Index)
        {
            return null;
        }

        public void let_ActiveConnection(object pvar)
        {
            
        }

        public void let_Source(string pvSource)
        {
            
        }

        public void set_Collect(object Index, object pvar)
        {
            
        }

        #endregion

        #region _Recordset 成员


        public void Save(object Destination, PersistFormatEnum PersistFormat)
        {
            
        }

        public void _xSave(string FileName, PersistFormatEnum PersistFormat)
        {
            
        }

        #endregion

        #region RecordsetEvents_Event 成员

        public event RecordsetEvents_EndOfRecordsetEventHandler EndOfRecordset;

        public event RecordsetEvents_FetchCompleteEventHandler FetchComplete;

        public event RecordsetEvents_FetchProgressEventHandler FetchProgress;

        public event RecordsetEvents_FieldChangeCompleteEventHandler FieldChangeComplete;

        public event RecordsetEvents_MoveCompleteEventHandler MoveComplete;

        public event RecordsetEvents_RecordChangeCompleteEventHandler RecordChangeComplete;

        public event RecordsetEvents_RecordsetChangeCompleteEventHandler RecordsetChangeComplete;

        public event RecordsetEvents_WillChangeFieldEventHandler WillChangeField;

        public event RecordsetEvents_WillChangeRecordEventHandler WillChangeRecord;

        public event RecordsetEvents_WillChangeRecordsetEventHandler WillChangeRecordset;

        public event RecordsetEvents_WillMoveEventHandler WillMove;

        #endregion
    }
}
