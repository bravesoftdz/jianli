// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbgridehgrouping.pas' rev: 21.00

#ifndef DbgridehgroupingHPP
#define DbgridehgroupingHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gridseh.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Dbsumlst.hpp>	// Pascal unit
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Stdactns.hpp>	// Pascal unit
#include <Propfilereh.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Memtreeeh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbgridehgrouping
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGridDataGroupLevelEh;
class DELPHICLASS TGridDataGroupLevelsEh;
class DELPHICLASS TGroupDataTreeNodeEh;
class PASCALIMPLEMENTATION TGridDataGroupLevelEh : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TColor FColor;
	Classes::TPersistent* FColumn;
	Graphics::TFont* FFont;
	Types::TRect FGroupPanelRect;
	Classes::TNotifyEvent FOnGetKeyValue;
	Classes::TNotifyEvent FOnGetTitleText;
	bool FParentColor;
	bool FParentFont;
	int FRowHeight;
	int FRowLines;
	Toolctrlseh::TSortOrderEh FSortOrder;
	Graphics::TColor __fastcall GetColor(void);
	Graphics::TFont* __fastcall GetFont(void);
	bool __fastcall IsColorStored(void);
	bool __fastcall IsFontStored(void);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColumn(const Classes::TPersistent* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetOnGetKeyValue(const Classes::TNotifyEvent Value);
	void __fastcall SetOnGetTitleText(const Classes::TNotifyEvent Value);
	void __fastcall SetParentColor(const bool Value);
	void __fastcall SetParentFont(const bool Value);
	void __fastcall SetRowHeight(const int Value);
	void __fastcall SetRowLines(const int Value);
	void __fastcall SetSortOrder(const Toolctrlseh::TSortOrderEh Value);
	
protected:
	Graphics::TColor __fastcall DefaultColor(void);
	Graphics::TFont* __fastcall DefaultFont(void);
	virtual void __fastcall DrawFormatChanged(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall RefreshDefaultFont(void);
	TGridDataGroupLevelsEh* __fastcall GridDataGroupLevels(void);
	
public:
	__fastcall virtual TGridDataGroupLevelEh(Classes::TCollection* Collection);
	__fastcall virtual ~TGridDataGroupLevelEh(void);
	virtual System::UnicodeString __fastcall GetGroupRowText(TGroupDataTreeNodeEh* GroupDataTreeNode);
	virtual System::Variant __fastcall GetKeyValue(void);
	void __fastcall CollapseNodes(void);
	void __fastcall ExtractNodes(void);
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, stored=IsColorStored, nodefault};
	__property Classes::TPersistent* Column = {read=FColumn, write=SetColumn};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont, stored=IsFontStored};
	__property Types::TRect GroupPanelRect = {read=FGroupPanelRect, write=FGroupPanelRect};
	__property bool ParentColor = {read=FParentColor, write=SetParentColor, default=1};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property int RowHeight = {read=FRowHeight, write=SetRowHeight, default=0};
	__property int RowLines = {read=FRowLines, write=SetRowLines, default=0};
	__property Toolctrlseh::TSortOrderEh SortOrder = {read=FSortOrder, write=SetSortOrder, default=0};
	__property Classes::TNotifyEvent OnGetKeyValue = {read=FOnGetKeyValue, write=SetOnGetKeyValue};
	__property Classes::TNotifyEvent OnGetTitleText = {read=FOnGetTitleText, write=SetOnGetTitleText};
};


class DELPHICLASS TGridDataGroupsEh;
class PASCALIMPLEMENTATION TGridDataGroupLevelsEh : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TGridDataGroupLevelEh* operator[](int Index) { return Items[Index]; }
	
private:
	TGridDataGroupsEh* FDataGroups;
	TGridDataGroupLevelEh* __fastcall GetDataGroup(int Index);
	void __fastcall SetDataGroup(int Index, const TGridDataGroupLevelEh* Value);
	Classes::TComponent* __fastcall GetGrid(void);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall RefreshDefaultFont(void);
	virtual void __fastcall OrderChanged(TGridDataGroupLevelEh* Item);
	
public:
	__fastcall TGridDataGroupLevelsEh(TGridDataGroupsEh* DataGroups, Classes::TCollectionItemClass ItemClass);
	HIDESBASE TGridDataGroupLevelEh* __fastcall Add(void);
	__property Classes::TComponent* Grid = {read=GetGrid};
	__property TGridDataGroupLevelEh* Items[int Index] = {read=GetDataGroup, write=SetDataGroup/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGridDataGroupLevelsEh(void) { }
	
};


class DELPHICLASS TGridGroupDataTreeEh;
class PASCALIMPLEMENTATION TGridDataGroupsEh : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FActive;
	Classes::TList* FActiveGroupColumns;
	Classes::TList* FActiveGroupLevels;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	Classes::TComponent* FGrid;
	TGridGroupDataTreeEh* FGroupDataTree;
	TGridDataGroupLevelsEh* FGroupLevels;
	bool FGroupPanelVisible;
	System::Variant FInsertingKeyValue;
	bool FParentColor;
	bool FParentFont;
	bool FDefaultStateExpanded;
	TGridDataGroupLevelEh* __fastcall GetActiveGroupLevels(const int Index);
	int __fastcall GetActiveGroupLevelsCount(void);
	Graphics::TColor __fastcall GetColor(void);
	Graphics::TFont* __fastcall GetFont(void);
	bool __fastcall IsColorStored(void);
	bool __fastcall IsFontStored(void);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGroupLevels(const TGridDataGroupLevelsEh* Value);
	void __fastcall SetGroupPanelVisible(const bool Value);
	void __fastcall SetParentColor(const bool Value);
	void __fastcall SetParentFont(const bool Value);
	
protected:
	virtual TGridDataGroupLevelsEh* __fastcall CreateGroupLevels(void);
	Graphics::TColor __fastcall DefaultColor(void);
	Graphics::TFont* __fastcall DefaultFont(void);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall ActiveGroupingStructChanged(void);
	void __fastcall CheckActiveGroupLevels(void);
	virtual void __fastcall DrawFormatChanged(void);
	void __fastcall FontChanged(System::TObject* Sender);
	virtual void __fastcall RebuildActiveGroupLevels(void);
	void __fastcall RefreshDefaultFont(void);
	virtual void __fastcall ResortActiveLevel(int LevelIndex, Toolctrlseh::TSortOrderEh SortOrder);
	
public:
	__fastcall TGridDataGroupsEh(Classes::TComponent* AGrid);
	__fastcall virtual ~TGridDataGroupsEh(void);
	System::Variant __fastcall GetKeyValueForViewRecNo(int ViewRecNo);
	virtual bool __fastcall IsGroupingWorks(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetInsertingKeyValue(const System::Variant &KeyValue);
	__property TGridDataGroupLevelEh* ActiveGroupLevels[const int Index] = {read=GetActiveGroupLevels};
	__property int ActiveGroupLevelsCount = {read=GetActiveGroupLevelsCount, nodefault};
	__property TGridGroupDataTreeEh* GroupDataTree = {read=FGroupDataTree};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, stored=IsColorStored, nodefault};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont, stored=IsFontStored};
	__property TGridDataGroupLevelsEh* GroupLevels = {read=FGroupLevels, write=SetGroupLevels};
	__property bool GroupPanelVisible = {read=FGroupPanelVisible, write=SetGroupPanelVisible, default=0};
	__property bool ParentColor = {read=FParentColor, write=SetParentColor, default=1};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property bool DefaultStateExpanded = {read=FDefaultStateExpanded, write=FDefaultStateExpanded, default=0};
};


#pragma option push -b-
enum TGroupDataTreeNodeTypeEh { dntDataSetRecordEh, dntDataGroupEh };
#pragma option pop

class PASCALIMPLEMENTATION TGroupDataTreeNodeEh : public Memtreeeh::TBaseTreeNodeEh
{
	typedef Memtreeeh::TBaseTreeNodeEh inherited;
	
public:
	TGroupDataTreeNodeEh* operator[](const int Index) { return Items[Index]; }
	
private:
	TGridDataGroupLevelEh* FDataGroup;
	int FDataSetRecordViewNo;
	System::Variant FFullKey;
	TGroupDataTreeNodeTypeEh FGroupDataTreeNodeType;
	System::Variant FKeyValue;
	int FRowHeight;
	bool FRowHeightNeedUpdate;
	TGroupDataTreeNodeEh* __fastcall GetDataItem(const int Index);
	int __fastcall GetRowHeight(void);
	void __fastcall SetRowHeight(const int Value);
	
public:
	void __fastcall RowDataChanged(void);
	void __fastcall UpdateRowHeight(void);
	__property Count;
	__property TGridDataGroupLevelEh* DataGroup = {read=FDataGroup};
	__property int DataSetRecordViewNo = {read=FDataSetRecordViewNo, nodefault};
	__property Expanded;
	__property System::Variant FullKey = {read=FFullKey};
	__property TGroupDataTreeNodeEh* Items[const int Index] = {read=GetDataItem/*, default*/};
	__property System::Variant KeyValue = {read=FKeyValue};
	__property Level;
	__property TGroupDataTreeNodeTypeEh NodeType = {read=FGroupDataTreeNodeType, nodefault};
	__property Parent;
	__property int RowHeight = {read=GetRowHeight, write=SetRowHeight, nodefault};
	__property bool RowHeightNeedUpdate = {read=FRowHeightNeedUpdate, nodefault};
public:
	/* TBaseTreeNodeEh.Create */ inline __fastcall virtual TGroupDataTreeNodeEh(void) : Memtreeeh::TBaseTreeNodeEh() { }
	/* TBaseTreeNodeEh.Destroy */ inline __fastcall virtual ~TGroupDataTreeNodeEh(void) { }
	
};


class PASCALIMPLEMENTATION TGridGroupDataTreeEh : public Memtreeeh::TTreeListEh
{
	typedef Memtreeeh::TTreeListEh inherited;
	
private:
	TGridDataGroupsEh* FGridDataGroups;
	Classes::TList* FlatVisibleList;
	int FUpateCount;
	TGroupDataTreeNodeEh* __fastcall GetFlatVisibleItem(const int Index);
	int __fastcall GetVisibleCount(void);
	
protected:
	virtual void __fastcall ExpandedChanged(Memtreeeh::TBaseTreeNodeEh* Node);
	void __fastcall CollapseLevel(int LevelIndex);
	void __fastcall ExpandLevel(int LevelIndex);
	
public:
	__fastcall TGridGroupDataTreeEh(TGridDataGroupsEh* AGridDataGroups, Memtreeeh::TTreeNodeClassEh ItemClass);
	__fastcall virtual ~TGridGroupDataTreeEh(void);
	TGroupDataTreeNodeEh* __fastcall AddRecordNodeForKey(const System::Variant &AKey);
	int __fastcall CompareNodes(Memtreeeh::TBaseTreeNodeEh* Node1, Memtreeeh::TBaseTreeNodeEh* Node2, System::TObject* ParamSort);
	TGroupDataTreeNodeEh* __fastcall GetFirstNodeAtLevel(int Level);
	TGroupDataTreeNodeEh* __fastcall GetNextNodeAtLevel(TGroupDataTreeNodeEh* Node, int Level);
	TGroupDataTreeNodeEh* __fastcall GetNodeByRecordViewNo(int RecordViewNo);
	TGroupDataTreeNodeEh* __fastcall GetNodeToInsertForKey1(TGroupDataTreeNodeEh* ParentNode, const System::Variant &Key1, Toolctrlseh::TSortOrderEh SortOrder, Memtreeeh::TNodeAttachModeEh &InsertMode);
	int __fastcall IndexOfVisibleNode(TGroupDataTreeNodeEh* Node);
	int __fastcall IndexOfVisibleRecordViewNo(int RecordViewNo);
	void __fastcall BeginUpdate(void);
	void __fastcall DeleteEmptyNodes(void);
	void __fastcall DeleteRecordNode(TGroupDataTreeNodeEh* RecNode);
	void __fastcall DeleteRecordNodes(void);
	void __fastcall DeleteRecordNodesUpToLevel(int Level);
	void __fastcall EndUpdate(void);
	void __fastcall ExpandNodePathToView(TGroupDataTreeNodeEh* Node);
	void __fastcall RebuildDataTree(Toolctrlseh::_di_IMemTableEh AIntMemTable);
	void __fastcall RebuildDataTreeEx(Toolctrlseh::_di_IMemTableEh AIntMemTable);
	void __fastcall RebuildFlatVisibleList(void);
	void __fastcall RecordChanged(int RecNum);
	void __fastcall RecordDeleted(int RecNum);
	void __fastcall RecordInserted(int RecNum);
	void __fastcall ResortLevel(int LevelIndex, Toolctrlseh::TSortOrderEh SortOrder);
	void __fastcall SetDataSetkeyValue(void);
	void __fastcall UpdateAllDataRowHeights(void);
	void __fastcall UpdateRecordNodePosInTree(TGroupDataTreeNodeEh* RecNode);
	__property int FlatVisibleCount = {read=GetVisibleCount, nodefault};
	__property TGroupDataTreeNodeEh* FlatVisibleItem[const int Index] = {read=GetFlatVisibleItem};
	__property TGridDataGroupsEh* GridDataGroups = {read=FGridDataGroups};
	__property int UpdateCount = {read=FUpateCount, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbgridehgrouping */
using namespace Dbgridehgrouping;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbgridehgroupingHPP
