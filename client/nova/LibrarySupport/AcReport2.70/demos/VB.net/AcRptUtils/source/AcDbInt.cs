using System;
using System.Data;
using System.Collections;
using System.Runtime.InteropServices;
using ADODB;

/// <summary>
/// Summary description for Class1
/// </summary>
/// 
namespace AcReport
{

    public static class DbAdapter : Object
    {
        public static void FillDataTableToAC(DataTable table, IAcRptEngine Engine)
        {
            //在2.5以后的版本中，可以用如下的方式将ADO.net的DataTable对象通过AcRecordsetAdapter转换为ADO接口的方式直接加入到AcEngine，
            //这样做就不需要在AC中复制一个复本，大大提高的速度。
            //
            AcReport.AcRecordsetAdapter RecordAdp = new AcReport.AcRecordsetAdapter(table);
            Engine.AddNetAdoData(table.TableName, RecordAdp);
        }

        public static void FillDatasetToAC(DataSet dataset, IAcRptEngine Engine)
        {
            //在2.5以后的版本中，可以用如下的方式将ADO.net的DataTable对象通过AcRecordsetAdapter转换为ADO接口的方式直接加入到AcEngine，
            //这样做就不需要在AC中复制一个复本，大大提高的速度。
            //
            for (int i = 0; i <= dataset.Tables.Count - 1; i++)
            {
                AcReport.AcRecordsetAdapter RecordAdp = new AcReport.AcRecordsetAdapter(dataset.Tables[i]);
                Engine.AddNetAdoData(dataset.Tables[i].TableName, RecordAdp);
            }
        }
    }

    public class AcPropAdapter : Object,ADODB.Property 
    {
        #region Property 成员

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

        public string Name
        {
            get { return ""; }
        }

        public DataTypeEnum Type
        {
            get { return DataTypeEnum.adInteger; }
        }

        public object Value
        {
            get
            {
                return 0;
            }
            set
            {
                
            }
        }

        #endregion
    }

    public class AcAdapterEnumerator : Object, System.Collections.IEnumerator
    {
        #region IEnumerator 成员

        public object Current
        {
            get { return 0; }
        }

        public bool MoveNext()
        {
            return false;
        }

        public void Reset()
        {
            
        }

        #endregion
    }

    [ClassInterface(ClassInterfaceType.None)]
    public class AcFieldPropsAdapter : Properties, _Collection, IEnumerable
    {

        #region IAcDbProps 成员

        public int Count
        { 
            get { return 0; }
        }

        public System.Collections.IEnumerator GetEnumerator()
        {
            return new AcAdapterEnumerator();
        }

        public void Refresh()
        {
          //  ADODB.InternalProperties ip = (InternalProperties)new object();
            
        }

        public Property this[object Index]
        {
            get { return new AcPropAdapter(); }
        }

        #endregion
    }

    public class AcPropsAdapter : Object, ADODB.Properties 
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

    [ClassInterface(ClassInterfaceType.None)]
    public class AcFieldAdapter: Object, ADODB.Field
    {
        private DataColumn FInnerField = null;
        private int Index = 0;
        private AcFieldPropsAdapter FProps = null;
        private AcRecordsetAdapter OwnerRecordset = null;
        private Recordset rsTmp = new Recordset(); //仅用于获取Properties对象

        public AcFieldAdapter(DataColumn oInnerField, int nIndex, AcRecordsetAdapter oOwnerRecordset)
        {
            //
            // TODO: Add constructor logic here
            //
            FProps = new AcFieldPropsAdapter();
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
                                              if (FieldType == typeof(double)) return DataTypeEnum.adDouble;
                                              else
                                              if (FieldType == typeof(DateTime)) return DataTypeEnum.adDBDate;
                                              else
                                                  if (FieldType == typeof(Array)) return DataTypeEnum.adBinary;
                                                  else

                                                      return DataTypeEnum.adVariant;

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
            get {
                if (typeof(string) == FInnerField.DataType)
                    return 500;
                else
                    return 0;
            }
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
                if (typeof(string) == FInnerField.DataType)
                    return 500;
                else
                    return 0;
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
            get 
            {
             //   ADODB.InternalProperties P = (InternalProperties)FProps;
              //  return FProps;
              
                return rsTmp.Properties;

            }
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
                    return oCurRow.ItemArray[this.Index];//[this.FInnerField.ColumnName]
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
            get { return 0; }
        }

        #endregion
    }

    [ClassInterface(ClassInterfaceType.None)]
    public class AcFieldsAdapter : Object, ADODB.Fields
    {
        public DataColumnCollection Columns = null;
        public AcRecordsetAdapter OwnerRecordset = null;
        private System.Collections.Generic.List<AcFieldAdapter> FieldList = new System.Collections.Generic.List<AcFieldAdapter>();

        public AcFieldsAdapter(AcRecordsetAdapter oOwnerRecordset)
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
               AcFieldAdapter aField = new AcFieldAdapter(Columns[i], i, OwnerRecordset);
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
            get 
            {
                if (FieldList.Count != Columns.Count)
                    RefreshFieldList();
                return FieldList.Count; 
            }
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
                return (Field)FieldList[i]; 
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

    public class AcRecordsetAdapter : Object, AcReport.IAcRecordset
    {
        public DataRowCollection Rows = null;
        public DataTable InnerTable = null;
        public AcFieldsAdapter ProxFields = null;
        private int CurRownIndex = 0;
        private PositionEnum PosState = PositionEnum.adPosUnknown;
        private AcPropsAdapter Props = new AcPropsAdapter();


        public AcRecordsetAdapter(DataTable oTable)
        {
            InnerTable = oTable;
            Rows = oTable.Rows;
            ProxFields = new AcFieldsAdapter(this);
        }

        public DataRow CurRow()
        {
            if (Rows.Count <= 0)
                return null;
            else 
                if (CurRownIndex <= Rows.Count - 1)
                   return Rows[CurRownIndex];
            else
                return Rows[Rows.Count - 1];
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

              PosState = PositionEnum.adPosUnknown;
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
            if (PosState == PositionEnum.adPosBOF)
            {
                PosState = PositionEnum.adPosUnknown;
                return;
            }
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
            if (PosState == PositionEnum.adPosEOF)
            { 
                PosState = PositionEnum.adPosUnknown;
                return;
            }

            PosState = PositionEnum.adPosUnknown;
            if (CurRownIndex > 0)
            {
                CurRownIndex--;
               // if (CurRownIndex == 0)
                 //   PosState = PositionEnum.adPosBOF;
            }
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
            if (CursorOptionEnum.adIndex == CursorOptions)
                return false;
            else
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
