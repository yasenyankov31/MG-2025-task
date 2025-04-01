import { useTranslation } from 'react-i18next';

const TranslateI18n = ({id}) => {
    const { t } = useTranslation();
    return (<>
        {t(id)}
    </>);
}

export default TranslateI18n;