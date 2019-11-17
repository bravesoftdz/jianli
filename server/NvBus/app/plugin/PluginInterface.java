package plugin;

import models.BPException;
import models.MetaForm;

public interface PluginInterface {
	/**
	 * 主表保存前操作
	 * @param form
	 * @param obj
	 * @return
	 * @throws BPException TODO
	 */
	Object mainBefore(MetaForm form,Object obj) throws BPException ;
	/**
	 * 主表保存后操作
	 * @param form
	 * @param obj
	 * @throws BPException TODO
	 */
	void mainAfter(MetaForm form,Object obj) throws BPException;
	/**
	 * 子表保存前操作
	 * @param form
	 * @param main	主表对象
	 * @param sub	子表对象
	 * @return
	 * @throws BPException TODO
	 */
	Object subBefore(MetaForm form,Object main,Object sub) throws BPException;
	/**
	 * 子表保存后操作
	 * @param form
	 * @param main	主表对象
	 * @param sub	子表对象
	 * @throws BPException TODO
	 */
	void subAfter(MetaForm form,Object main,Object sub) throws BPException;
}
